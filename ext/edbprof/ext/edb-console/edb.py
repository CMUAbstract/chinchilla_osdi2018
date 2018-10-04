#!/usr/bin/python3.5

import sys
import traceback
import os
import time
import atexit
import readline # loading this causes raw_input to offer a rich prompt
import argparse
import re

from pyedb import edb

parser = argparse.ArgumentParser(
            description="EDB Console")
parser.add_argument('--command', '-c',
            help="Run the given command and exit")
parser.add_argument('--stdio', '-o',
            help="File to which to pipe std I/O data relayed from target (default: console)")
args = parser.parse_args()

monitor = None
active_mode = False

if args.stdio is not None:
    CONSOLE_FILE = open(args.stdio, "w")
else:
    CONSOLE_FILE = sys.stdout

def to_int(s):
    if s.startswith("0x"):
        return int(s, 16)
    else:
        return int(s)

def match_keyword(part, words):
    match = None
    for word in words:
        if word.startswith(part):
            if match is not None:
                raise Exception("Ambiguous keyword: " + part)
            match = word
    return match

def print_interrupt_context(context):
    print("Interrupted: %r " % context.type, end='')
    if context.type == "ASSERT":
        print("line: %r" % context.id, end='')
    elif context.type == "BOOT":
        pass
    else:
        print("id: %r" % context.id, end='')
    if context.saved_vcap is not None:
        print(" Vcap_saved = %.4f" % context.saved_vcap)
    else:
        print()

def print_watchpoint_event(event):
    print("Watchpoint: id: %r time: %.6f s Vcap = %.4f" % \
            (event.id, event.timestamp, event.vcap))

def init_watchpoint_log(fout):
    fout.write("id,timestamp,vcap\n")
def log_watchpoint_event(fout, event):
    fout.write("%u,%.6f,%.4f\n" %  (event.id, event.timestamp, event.vcap))

class Command:
    def __init__(self, name, parser, handler):
        self.name = name
        self.parser = parser
        self.handler = handler
        self.description = parser.description

CMD_HANDLER_FUNC_PREFIX = "cmd_"
CMD_PARSER_FUNC_PREFIX = "parser_"

class CommandNotFoundException(Exception):
    def __init__(self, name):
        self.name = name

class DebuggerNotAttachedException(Exception):
    pass

def lookup_cmd(name):
    try:
        glob = globals()
        parser = glob[CMD_PARSER_FUNC_PREFIX + name]()
        handler = glob[CMD_HANDLER_FUNC_PREFIX + name]
        return Command(name, parser, handler)
    except KeyError:
        raise CommandNotFoundException(name)

def lookup_all_cmds():

    cmds = []

    glob = globals()
    for var in glob:
        m = re.match(r'^' + CMD_HANDLER_FUNC_PREFIX + r'(?P<cmd_name>.*)', var)
        if m is None:
            continue
        cmd_name = m.group('cmd_name')

        # guard against coincidences in function names
        if CMD_PARSER_FUNC_PREFIX + cmd_name not in glob:
            continue

        cmd = lookup_cmd(cmd_name)
        cmds.append(cmd)

    return sorted(cmds, key=lambda cmd: cmd.name)

def add_toggle_arg(parser, state_details):
    parser.add_argument('state', choices=['E', 'D'], type=str.upper,
                        help=state_details + " state to apply (E|D)")
def eval_toggle_arg(state):
    return state == "E"

def check_attached(mon):
    if mon is None:
        raise DebuggerNotAttachedException()


def parser_help():
    parser = argparse.ArgumentParser(prog="help",
                description="Display a list of commands")
    return parser

def cmd_help(mon, args):
    print("Run a command with --help to see its usage information")
    cmds = lookup_all_cmds()
    for cmd in cmds:
        print("%16s : %s" % (cmd.name, cmd.description))
        print("%16s   %s" % ("", cmd.parser.format_usage()))

def parser_echo():
    parser = argparse.ArgumentParser(prog="echo",
                description="A test command that prints its input arg")
    parser.add_argument('value', help="a string to echo back")
    return parser

def cmd_echo(mon, args):
    print(args.value)

def parser_sleep():
    parser = argparse.ArgumentParser(prog="sleep",
                description="Sleep for a designated number of seconds")
    parser.add_argument('time_sec', help="time to sleep (seconds)")
    return parser

def cmd_sleep(mon, args):
    time.sleep(float(args.time_sec))

def parser_attach():
    parser = argparse.ArgumentParser(prog="attach",
                description="Connect to the debugger device over TTY USB")
    parser.add_argument('--device', '-d', help="device file", default='/dev/ttyUSB0')
    parser.add_argument('--uart-log', '-l', help="file to where to log bytes received over UART")
    return parser

def cmd_attach(mon, args):
    global monitor
    monitor = edb.EDB(device=args.device, uart_log_fname=args.uart_log)

def parser_detach():
    parser = argparse.ArgumentParser(prog="detach",
                description="Disconnect from the debugger device")
    return parser

def cmd_detach(mon, args):
    check_attached(mon)
    mon.destroy()

def parser_power():
    parser = argparse.ArgumentParser(prog="power",
                description="Turn on/off continuous power to the target device")
    parser.add_argument('action', choices=['on', 'off'], help="power state to set")
    return parser

def cmd_power(mon, args):
    check_attached(mon)
    mon.cont_power(args.action == "on")

def parser_sense():
    parser = argparse.ArgumentParser(prog="sense",
                description="Sample voltage on an ADC channel")
    parser.add_argument('channel', type=str.upper,
                        help="ADC channel which to sample",
                        choices=edb.EDB.get_adc_channels())
    return parser

def cmd_sense(mon, args):
    check_attached(mon)
    print(mon.sense(args.channel))

def parser_reset():
    parser = argparse.ArgumentParser(prog="reset",
                description="Reset the state machine that tracks debug mode state")
    return parser

def cmd_reset(mon, args):
    check_attached(mon)
    mon.reset_debug_mode_state()

def parser_stream():
    parser = argparse.ArgumentParser(prog="stream",
                description="Collect a stream of energy or program events " +
                            "(Ctrl-C to interrupt)")
    parser.add_argument('streams', nargs='+', choices=edb.EDB.get_streams(),
                        type=str.upper, help="event types to collect")
    parser.add_argument('--duration_sec', '-d', type=float,
                        help="how long to collect the trace for (sec)")
    parser.add_argument('--out-file', '-o', help="file where to save the trace")
    parser.add_argument('--no-parse', action='store_true',
                        help="disable packet parsing (for debugging)")
    return parser

def cmd_stream(mon, args):
    check_attached(mon)
    if args.out_file is None:
        fp = sys.stdout
        silent = True
    else:
        fp = open(args.out_file, "w")
        silent = False

    try:
        mon.stream(args.streams, duration_sec=args.duration_sec, out_file=fp,
                   silent=silent, no_parse=args.no_parse)
    except KeyboardInterrupt:
        pass # this is a clean termination

def parser_charge():
    parser = argparse.ArgumentParser(prog="charge",
                description="Set energy level of target device up to given voltage")
    parser.add_argument('voltage', help="voltage to charge capacitor to (V)")
    parser.add_argument('--method', '-m', help="implementation variant",
                        type=str.upper, choices=['ADC', 'CMP'], default='ADC')
    return parser

def cmd_charge(mon, args):
    check_attached(mon)
    target_voltage = float(args.voltage)
    if args.method == "ADC":
        vcap = mon.charge(target_voltage)
        print("Vcap = %.4f" % vcap)
    elif args.method == "CMP":
        mon.charge_cmp(target_voltage)

def parser_discharge():
    parser = argparse.ArgumentParser(prog="discharge",
                description="Set energy level of target device down to a given voltage")
    parser.add_argument('voltage', help="voltage to discharge capacitor to (V)")
    parser.add_argument('--method', '-m', help="implementation variant",
                        type=str.upper, choices=['ADC', 'CMP'], default='ADC')
    return parser

def cmd_discharge(mon, args):
    check_attached(mon)
    target_voltage = float(args.voltage)
    if args.method == "ADC":
        vcap = mon.discharge(target_voltage)
        print("Vcap = %.4f" % vcap)
    elif args.method == "CMP":
        mon.discharge_cmp(target_voltage)

def parser_int():
    parser = argparse.ArgumentParser(prog="int",
                description="Interrupt target device and enter interactive debug shell")
    return parser

def cmd_int(mon, args):
    check_attached(mon)
    global active_mode
    try:
        saved_vcap = mon.interrupt()
        print("Vcap_saved = %.4f" % saved_vcap)
        active_mode = True
    except KeyboardInterrupt:
        pass

def parser_cont():
    parser = argparse.ArgumentParser(prog="cont",
                description="Resume program execution")
    return parser

def cmd_cont(mon, args):
    check_attached(mon)
    global active_mode
    restored_vcap = mon.exit_debug_mode()
    print("Vcap_restored = %.4f" % restored_vcap)
    active_mode = False

def parser_ebreak():
    parser = argparse.ArgumentParser(prog="ebreak",
                description="Set an energy-breakpoint")
    parser.add_argument('voltage', help="voltage level at which to interrupt")
    parser.add_argument('--method', '-m', help="implementation variant",
                        type=str.upper, choices=['ADC', 'CMP'], default='ADC')
    return parser

def cmd_ebreak(mon, args):
    check_attached(mon)
    global active_mode
    target_voltage = float(args.target_voltage)
    saved_vcap = mon.break_at_vcap_level(target_voltage, args.method)
    print("Vcap_saved = %.4f" % saved_vcap)
    active_mode = True

def parser_break():
    parser = argparse.ArgumentParser(prog="break",
                description="Toggle a code or code-energy breakpoint")
    parser.add_argument('idx', type=int,
                        help="breakpoint index (must match the macro in app source code)")
    add_toggle_arg(parser, "breakpoint")
    parser.add_argument('--voltage', type=float,
                        help="make this an code-energy breakpoint with the given voltage level (V)")
    parser.add_argument('--type', choices=edb.EDB.get_breakpoint_types(),
                        default='EXTERNAL', type=str.upper,
                        help="breakpoint type (impl. variant)")
    return parser

def cmd_break(mon, args):
    check_attached(mon)
    mon.toggle_breakpoint(args.type, args.idx, eval_toggle_arg(args.state), args.voltage)

def parser_watch():
    parser = argparse.ArgumentParser(prog="watch",
                description="Toggle a code or code-energy watchpoint")
    parser.add_argument('idx', type=int,
                        help="watchpoint index (must match the macro in app source code)")
    add_toggle_arg(parser, "watchpoint")
    parser.add_argument('--energy', action='store_true',
                        help="snapshot energy at the watchpoint location")
    return parser

def cmd_watch(mon, args):
    check_attached(mon)
    mon.toggle_watchpoint(args.idx, eval_toggle_arg(args.state), args.energy)

def parser_wait():
    parser = argparse.ArgumentParser(prog="wait",
                description="Wait for a breakpoint and enter active debug mode or collect printf output")
    parser.add_argument('--log-file', '-l',
                        help="filename where to log printf output")
    return parser

def cmd_wait(mon, args):
    check_attached(mon)
    global active_mode

    if args.log_file is not None:
        flog = open(args.log_file, "w")
        init_watchpoint_log(flog)
    else:
        flog = None

    try:
        start_time = time.time()
        while True:
            event = mon.wait()

            if isinstance(event, edb.InterruptContext):
                print_interrupt_context(event)
                active_mode = True
                break
            if isinstance(event, edb.WatchpointEvent):
                print_watchpoint_event(event)
                if flog is not None:
                    log_watchpoint_event(flog, event)
            elif isinstance(event, edb.StdIOData):
                CONSOLE_FILE.write("%.03f: " % (event.timestamp - start_time))
                CONSOLE_FILE.write(event.string)
                CONSOLE_FILE.flush()
                if event.string[-1] != '\n':
                    CONSOLE_FILE.write('\n')
            elif isinstance(event, edb.EnergyProfile):
                print("%.03f: %r" % (event.timestamp - start_time, event.profile))

    except KeyboardInterrupt:
        pass

def parser_intctx():
    parser = argparse.ArgumentParser(prog="intctx",
                description="Show context of the interrupt that triggered current debug session")
    parser.add_argument('--source', '-s', choices=edb.EDB.get_interrupt_sources(), type=str.upper,
                        default='DEBUGGER', help="where to fetch the interrupt context from")
    return parser

def cmd_intctx(mon, args):
    check_attached(mon)
    int_context = mon.get_interrupt_context(args.source)
    print_interrupt_context(int_context)

def add_addr_arg(parser):
    parser.add_argument('addr', type=to_int, help="memory address(hex)")

def parser_read():
    parser = argparse.ArgumentParser(prog="read",
                description="Read content of memory on the target device")
    add_addr_arg(parser)
    parser.add_argument('len', type=int, help="number of bytes to read")
    return parser

def cmd_read(mon, args):
    check_attached(mon)
    addr, value = mon.read_mem(args.addr, args.len)
    print("%08x: " % addr, end='')
    for byte in value:
        print("%02x " % byte, end='')
    print()

def parser_write():
    parser = argparse.ArgumentParser(prog="write",
                description="Write content to memory on the target device")
    add_addr_arg(parser)
    parser.add_argument('value', nargs='+', type=to_int,
                        help="array of bytes to write (space-separated)")
    return parser

def cmd_write(mon, addr, *value):
    check_attached(mon)
    mon.write_mem(args.addr, args.value)

def parser_pc():
    parser = argparse.ArgumentParser(prog="pc",
                description="Get program counter from target device")
    return parser

def cmd_pc(mon, args):
    check_attached(mon)
    print("0x%08x" % mon.get_pc())

def parser_eecho():
    parser = argparse.ArgumentParser(prog="eecho",
                description="Echo value from EDB or target device (for debugging)")
    parser.add_argument('source', choices=['SERIAL', 'DMA'], type=str.upper,
                        help="what code path to test")
    parser.add_argument('value', type=to_int, help="value to echo back")
    return parser

def cmd_eecho(mon, value):
    check_attached(mon)
    if args.source == "SERIAL":
        print("0x%02x" % mon.serial_echo(value))
    elif args.source == "DMA":
        print("0x%02x" % mon.dma_echo(value))

def parser_replay():
    parser = argparse.ArgumentParser(prog="replay",
                description="Load UART log for replaying (for debugging)")
    parser.add_argument('log_file', help="file with the recorded uart log")
    return parser

def cmd_replay(mon, args):
    mon.load_replay_log(args.log_file)

def add_param_args(parser):
    parser.add_argument('param', help="parameter name")
    parser.add_argument('--owner', choices=['HOST', 'EDB'], default='EDB',
                        help="entity that owns the parameter")
    parser.add_argument('--raw', action='store_true',
                        help="disable type conversions for value (in/out in raw representation)")

def parser_set():
    parser = argparse.ArgumentParser(prog="set",
                description="Set value of a parameter")
    add_param_args(parser)
    parser.add_argument('value', help="value to set parameter to")
    return parser

def cmd_set(mon, args):
    check_attached(mon)
    if args.owner == "HOST":
        print(mon.set_local_param(args.param, args.value))

    elif args.owner == "EDB":

        param_type = mon.get_remote_param_type(args.param)
        if args.raw:
            typed_value = param_type.from_edb_repr(mon, args.value)
        else:
            typed_value = param_type.from_string(args.value)

        set_value = mon.set_remote_param(args.param, typed_value)

        if args.raw:
            print(set_value.to_edb_repr(mon))
        else:
            print(set_value)


def parser_get():
    parser = argparse.ArgumentParser(prog="get",
                description="Get the value of a parameter")
    add_param_args(parser)
    return parser

def cmd_get(mon, args):
    check_attached(mon)
    if args.owner == "HOST":
        print(mon.get_local_param(args.param))
    elif args.owner == "EDB":
        value = mon.get_remote_param(args.param)
        if args.raw:
            print(value.to_edb_repr(mon))
        else:
            print(value)

def parser_uart():
    parser = argparse.ArgumentParser(prog="uart",
                description="Toggle UART on EDB side")
    parser.add_argument('state', choices=['E', 'D'], type=str.upper,
                        help="state into which to set the UART")
    parser.add_argument('state', choices=['E', 'D'], type=str.upper,
                        help="state to apply")
    add_toggle_arg(parser, "UART")
    return parser

def cmd_uart(mon, args):
    check_attached(mon)
    mon.enable_target_uart(eval_toggle_arg(args.state))

def parser_payload():
    parser = argparse.ArgumentParser(prog="payload",
                description="Enable periodic sending of payload (EDBSat)")
    add_toggle_arg(parser, "periodic-send")
    return parser

def cmd_payload(mon, args):
    check_attached(mon)
    mon.enable_periodic_payload(eval_toggle_arg(args.state))

def compose_prompt(active_mode):
    if active_mode:
        return "*> "
    return "> "

cmd_hist_file = os.path.join(os.path.expanduser("~"), ".edb_history")
try:
    readline.read_history_file(cmd_hist_file)
except IOError:
    pass
atexit.register(readline.write_history_file, cmd_hist_file)

while True:

    if args.command is not None:
        once = True
        line = args.command
    else: # read from stdin
        once = False
        try:
            line = input(compose_prompt(active_mode))
        except EOFError:
            print() # print a newline to be nice to the shell
            break
        except KeyboardInterrupt:
            print() # move to next line
            continue

    line = line.strip()
    if len(line) == 0: # new-line character only (blank command)
        continue
    if line.startswith("#"): # comment
        continue
    cmd_lines = line.split(';')
    try:
        for cmd_line in cmd_lines:
            tokens = cmd_line.split()
            cmd_name = tokens[0]
            cmd_args = tokens[1:]
            cmd = lookup_cmd(cmd_name)
            cmd.handler(monitor, cmd.parser.parse_args(cmd_args))

    except CommandNotFoundException as e:
        print("Unrecognized command: '" + e.name + "'. Try 'help'.")

    except DebuggerNotAttachedException:
        print("Not connected to debugger: run 'attach' command.")

    except Exception as e:
        print(type(e))
        print(traceback.format_exc())

    except SystemExit: # prevent parse_args from exiting on '--help' or usage
        pass

    if once:
        break
