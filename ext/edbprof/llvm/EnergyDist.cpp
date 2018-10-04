
#include "EnergyDist.h"

#include "llvm/Support/raw_ostream.h"

#include <algorithm>

#define DEBUG_TYPE "EnergyDist"

using namespace llvm;

namespace {

const unsigned SHIFT_WIDTH = 2;

} // anon namespace

namespace edbprof {

EnergyDist& EnergyDist::operator+(const EnergyDist &rhs)
{
  // Sum of two normal distributions is a normal distribution
  Mean += rhs.Mean;
  Var += rhs.Var;
  return *this;
}

std::basic_ostream<char>& CompositeDistExpr::print(std::basic_ostream<char>& os, unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  os << "(";
  printOp(os);
  if (pretty)
    os << "\n";
  else
    os << " ";
  for (auto &operand : Operands) {
    operand->print(os, level + 1, pretty);
    if (pretty)
      os << "\n";
    else
      os << " ";
  }
  if (pretty)
    os << indent;
  os << ")";
  return os;
}

std::basic_ostream<char>& WeightDistExpr::print(std::basic_ostream<char>& os,
                                                unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  return os << Weight;
}

std::basic_ostream<char>& IntDistExpr::print(std::basic_ostream<char>& os,
                                             unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  return os << Value;
}

WeightedDistExpr::WeightedDistExpr(DistExprPtr dist, float weight) :
    CompositeDistExpr(EXPR_WEIGHTED), Weight(weight)
{
  assert(Operands.empty());
  Operands.push_back(dist);
  Operands.push_back(WeightDistExprPtr(new WeightDistExpr(weight)));
}

std::basic_ostream<char>& WeightedDistExpr::printOp(std::basic_ostream<char>& os) const
{
  return os << "^";
}

MultDistExpr::MultDistExpr(DistExprPtr dist, int reps) :
    CompositeDistExpr(EXPR_MULT), Reps(reps)
{
  assert(Operands.empty());
  Operands.push_back(dist);
  Operands.push_back(IntDistExprPtr(new IntDistExpr(reps)));
}

std::basic_ostream<char>& MultDistExpr::printOp(std::basic_ostream<char>& os) const
{
  return os << "*";
}

NormalDistExpr::NormalDistExpr(float mean, float var)
  : DistExpr(EXPR_NORMAL), Mean(mean), Var(var)
{
}

// for legacy compat
NormalDistExpr::NormalDistExpr(const EnergyDist &energyDist)
  : DistExpr(EXPR_NORMAL), Mean(energyDist.Mean), Var(energyDist.Var)
{
}

std::basic_ostream<char>& NormalDistExpr::print(std::basic_ostream<char>& os, unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  return os << "(N " << Mean << " " << Var << ")";
}

SumDistExpr &SumDistExpr::operator+=(SumDistExpr &rhs)
{
#if 0
  for (auto &operand : rhs.Operands)
    Operands.push_back(operand);
#endif
  Operands.reserve(Operands.size() + rhs.Operands.size());
  std::copy(rhs.Operands.begin(), rhs.Operands.end(), Operands.begin());
  return *this;
}

SumDistExpr &SumDistExpr::operator+=(DistExprPtr rhs)
{
  Operands.push_back(rhs);
  return *this;
}

std::basic_ostream<char>& SumDistExpr::printOp(std::basic_ostream<char>& os) const
{
  return os << "+";
}

MixDistExpr &MixDistExpr::mix(MixDistExpr &rhs)
{
  Operands.reserve(Operands.size() + rhs.Operands.size());
  std::copy(rhs.Operands.begin(), rhs.Operands.end(), Operands.begin());
  return *this;
}

MixDistExpr &MixDistExpr::mix(WeightedDistExprPtr rhs)
{
  Operands.push_back(rhs);
  return *this;
}

std::basic_ostream<char>& MixDistExpr::printOp(std::basic_ostream<char>& os) const
{
  return os << "&";
}

SumDistExprPtr operator+(DistExprPtr distA, DistExprPtr distB)
{
  SumDistExprPtr r(new SumDistExpr());
  r->Operands.push_back(distA);
  r->Operands.push_back(distB);
  return r;
}

MixDistExprPtr mix(float weightA, DistExprPtr distA, float weigthB, DistExprPtr distB)
{
  MixDistExprPtr r(new MixDistExpr());
  r->Operands.push_back(distA);
  r->Operands.push_back(distB);
  return r;
}

std::basic_ostream<char>& ZeroDistExpr::print(std::basic_ostream<char>& os, unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  return os << "(Z)";
}

DistExpr &ScalarDistExpr::operator+=(const DistExpr &rhs)
{
    assert(rhs.Type == EXPR_SCALAR && "LHS does not support operator+= on RHS");
    const ScalarDistExpr *rhsScalar = static_cast<const ScalarDistExpr *>(&rhs);
    Value += rhsScalar->Value;
    return *this;
}

DistExpr &ScalarDistExpr::operator*=(float rhs)
{
    Value *= rhs;
    return *this;
}

DistExpr &ScalarDistExpr::operator/=(float rhs)
{
    Value /= rhs;
    return *this;
}

bool ScalarDistExpr::operator<(const DistExpr &rhs) const
{
    assert(rhs.Type == EXPR_SCALAR && "LHS does not support operator< on RHS");
    const ScalarDistExpr *rhsScalar = static_cast<const ScalarDistExpr *>(&rhs);
    return Value < rhsScalar->Value;
}

bool ScalarDistExpr::operator>(const DistExpr &rhs) const
{
    assert(rhs.Type == EXPR_SCALAR && "LHS does not support operator< on RHS");
    const ScalarDistExpr *rhsScalar = static_cast<const ScalarDistExpr *>(&rhs);
    return Value > rhsScalar->Value;
}

bool ScalarDistExpr::operator<(float rhs) const
{
    return Value < rhs;
}

bool ScalarDistExpr::operator>(float rhs) const
{
    return Value > rhs;
}

ScalarDistExpr::operator float() const
{
    return Value;
}

std::basic_ostream<char>& ScalarDistExpr::print(std::basic_ostream<char>& os, unsigned level, bool pretty) const
{
  std::string indent(level * SHIFT_WIDTH, ' ');
  if (pretty)
    os << indent;
  return os << Value;
}

std::basic_ostream<char>& HistDistExpr::print(std::basic_ostream<char>& os, unsigned level, bool pretty) const
{
  if (pretty) {
    std::string indent(level * SHIFT_WIDTH, ' ');
    os << indent;
  }
  return os << "(H " << Hash << ")";
}

std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, EnergyDist ed)
{
  os << "(" << ed.Mean << ", " << ed.Var << ")";
  return os;
}

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const DistExpr &expr)
{
  std::ostringstream ss;
  expr.print(ss, /* level */ 0, /* pretty */ true);
  return os << ss.str();
}

std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, const DistExpr &expr)
{
  std::ostringstream ss;
  expr.print(ss, /* level */ 0, /* pretty */ false);
  return os << ss.str();
}

} // namespace edbprof
