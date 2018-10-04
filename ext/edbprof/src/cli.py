def split_args(s):
    """Split white-space-separated arguments respecting quoting"""

    STATE_SPACE = 0
    STATE_ARG = 1
    STATE_ARG_QUOTE = 2

    state = STATE_SPACE

    args = []
    i = 0
    arg = ''
    for i in range(len(s)):
        if s[i] in [' ', "\t"]:
            if state == STATE_ARG:
                args += [arg]
                state = STATE_SPACE
            elif state == STATE_ARG_QUOTE:
                arg += s[i]
            elif state == STATE_SPACE:
                pass
        elif s[i] == "'":
            if state == STATE_ARG:
                raise Exception("invalid cli arg string: quote inside arg")
            elif state == STATE_SPACE:
                arg = ''
                state = STATE_ARG_QUOTE
            elif state == STATE_ARG_QUOTE:
                state = STATE_ARG
        else:
            if state in [STATE_ARG, STATE_ARG_QUOTE]:
                arg += s[i]
            elif state == STATE_SPACE:
                arg = s[i]
                state = STATE_ARG

    if state == STATE_ARG_QUOTE:
        raise Exception("invalid cli arg string: unterminate quoted arg")
    elif state == STATE_ARG:
        args += [arg]

    return args
