#ifndef EDBPROF_ENERGY_DIST_H
#define EDBPROF_ENERGY_DIST_H

#include "BlockHash.h"

#include "llvm/Support/raw_ostream.h"

#include <utility>
#include <vector>
#include <sstream>

namespace edbprof {

struct EnergyDist {
  // Sum of normally distributed random variables (block energy): normal
  float Mean;
  float Var;

  EnergyDist(float mean, float stddev) :
    Mean(mean), Var(stddev) {}
  EnergyDist() : Mean(0), Var(0) {}
  EnergyDist(const EnergyDist &rhs) :
    Mean(rhs.Mean), Var(rhs.Var) {}

  EnergyDist& operator+(const EnergyDist &rhs);
};

typedef enum {
  DIST_OP_ADD,
  DIST_OP_MIX,
} dist_op_t;

// for debugging
typedef enum {
  EXPR_NONE = 0,
  EXPR_MIX,
  EXPR_SUM,
  EXPR_NORMAL,
  EXPR_ZERO,
  EXPR_INT,
  EXPR_WEIGHT,
  EXPR_WEIGHTED,
  EXPR_MULT,
  EXPR_SCALAR,
  EXPR_HIST,
} expr_t;

struct DistExpr;
struct WeightDistExpr;
struct IntDistExpr;
struct WeightedDistExpr;
struct MultDistExpr;
struct ScalarDistExpr;
typedef std::shared_ptr<DistExpr> DistExprPtr;
typedef std::shared_ptr<WeightDistExpr> WeightDistExprPtr;
typedef std::shared_ptr<IntDistExpr> IntDistExprPtr;
typedef std::shared_ptr<WeightedDistExpr> WeightedDistExprPtr;
typedef std::shared_ptr<MultDistExpr> MultDistExprPtr;
typedef std::shared_ptr<ScalarDistExpr> ScalarDistExprPtr;

struct DistExpr {
  expr_t Type; // for diag
  float MaxValue;

  virtual std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                                   unsigned level, bool pretty) const = 0;

 protected:
  DistExpr(expr_t type) : Type(type), MaxValue(0.0) { }

 public:
  virtual bool operator<(const DistExpr &rhs) const  {
    assert(false && "object does not support operator< on DistExpr");
  };
  virtual bool operator>(const DistExpr &rhs) const  {
    assert(false && "object does not support operator> on DistExpr");
  };
  virtual bool operator<(float rhs) const  {
    assert(false && "object does not support operator< on float");
  };
  virtual bool operator>(float rhs) const  {
    assert(false && "object does not support operator> on float");
  };

  virtual DistExpr &operator+=(const DistExpr &rhs) {
    assert(false && "object does not support operator+= on DistExpr");
  }
  virtual DistExpr &operator*=(float rhs) {
    assert(false && "object does not support operator*= on float");
  }
  virtual DistExpr &operator/=(float rhs) {
    assert(false && "object does not support operator/= on float");
  }

  virtual operator float() const {
    assert(false && "object does not support conversion to float");
  }
};

struct CompositeDistExpr : public DistExpr {
  std::vector<DistExprPtr> Operands;

  virtual std::basic_ostream<char>& printOp(std::basic_ostream<char>& os) const = 0;
  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;

 protected:
  CompositeDistExpr(expr_t type) : DistExpr(type) { }
};

struct WeightDistExpr : public DistExpr {
  float Weight;

  WeightDistExpr(float weight) : DistExpr(EXPR_WEIGHT), Weight(weight) { }
  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;
};

struct IntDistExpr : public DistExpr {
  int Value;

  IntDistExpr(int value) : DistExpr(EXPR_INT), Value(value) { }
  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;
};

struct WeightedDistExpr : public CompositeDistExpr {
  float Weight;

  WeightedDistExpr(DistExprPtr dist, float weight);

  std::basic_ostream<char>& printOp(std::basic_ostream<char>& os) const override;
};

struct MultDistExpr : public CompositeDistExpr {
  float Reps;

  MultDistExpr(DistExprPtr dist, int reps);

  std::basic_ostream<char>& printOp(std::basic_ostream<char>& os) const override;
};

struct MixDistExpr : public CompositeDistExpr {
  MixDistExpr() : CompositeDistExpr(EXPR_MIX) { }

  MixDistExpr &mix(MixDistExpr &rhs);
  MixDistExpr &mix(WeightedDistExprPtr rhs);

  std::basic_ostream<char>& printOp(std::basic_ostream<char>& os) const override;
};

struct SumDistExpr : public CompositeDistExpr {
  SumDistExpr() : CompositeDistExpr(EXPR_SUM) { }

  SumDistExpr &operator+=(SumDistExpr &rhs);
  SumDistExpr &operator+=(DistExprPtr rhs);

  std::basic_ostream<char>& printOp(std::basic_ostream<char>& os) const override;
};

struct NormalDistExpr : public DistExpr {
  float Mean;
  float Var;

  NormalDistExpr(float mean, float var);
  NormalDistExpr(const EnergyDist &energyDist); // for legacy compat

  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;
};

struct ZeroDistExpr : public DistExpr {
  ZeroDistExpr() : DistExpr(EXPR_ZERO) { }

  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;
};

// NOTE: This wrapper around a simple float exists only to let
// the code in GreedyBoundaryPlacer be the same as in PathEnergyEstimator
// (eventually, same code shuould re-used instead of copy-paste).
struct ScalarDistExpr : public DistExpr {
  float Value;

  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                                   unsigned level, bool pretty) const override;

  ScalarDistExpr() : DistExpr(EXPR_SCALAR), Value(0.0) { }
  ScalarDistExpr(float value) : DistExpr(EXPR_SCALAR), Value(value) { }

  DistExpr &operator+=(const DistExpr &rhs) override;
  DistExpr &operator*=(float rhs) override;
  DistExpr &operator/=(float rhs) override;
  bool operator<(const DistExpr &rhs) const override;
  bool operator>(const DistExpr &rhs) const override;
  bool operator<(float rhs) const override;
  bool operator>(float rhs) const override;

  operator float() const override;
};

// Distribution defined by a histogram of raw data: points to a file
struct HistDistExpr : public DistExpr {
  BlockHash Hash;

  HistDistExpr() : DistExpr(EXPR_HIST), Hash() { }
  HistDistExpr(const BlockHash& hash) : DistExpr(EXPR_HIST), Hash(hash) { }

  std::basic_ostream<char>& print(std::basic_ostream<char>& os,
                           unsigned level, bool pretty) const override;
};

typedef std::shared_ptr<CompositeDistExpr> CompositeDistExprPtr;
typedef std::shared_ptr<MixDistExpr> MixDistExprPtr;
typedef std::shared_ptr<SumDistExpr> SumDistExprPtr;
typedef std::shared_ptr<ZeroDistExpr> ZeroDistExprPtr;
typedef std::shared_ptr<NormalDistExpr> NormalDistExprPtr;
typedef std::shared_ptr<HistDistExpr> HistDistExprPtr;

NormalDistExpr operator+(const NormalDistExpr &distA, const NormalDistExpr &distB);
SumDistExprPtr operator+(DistExprPtr distA, DistExprPtr distB);
MixDistExprPtr mix(float weightA, DistExprPtr distA, float weigthB, DistExprPtr distB);

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, EnergyDist ed);

llvm::raw_ostream& operator<<(llvm::raw_ostream& os, const DistExpr &ed);
std::basic_ostream<char>& operator<<(std::basic_ostream<char>& os, const DistExpr &expr);

} // namespace edbprof

#endif // EDBPROF_ENERGY_DIST_H
