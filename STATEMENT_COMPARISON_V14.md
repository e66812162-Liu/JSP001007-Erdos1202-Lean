# Statement comparison — JSP-001007 / Erdős #1202 — V14

Date: 2026-09-24

## Purpose

V14 is the canonical external-review wrapper after a closed adversarial
statement audit.  The mathematical counterexample is unchanged from V12.

The audit deliberately tested whether small convention choices around `k`,
the domain of `n`, half-cardinality, and terminal strictness could create a
statement-fidelity objection.

## V14 target

```lean
def Erdos1202SourceStatementV14 : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        0 < n →
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i,
          (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV14 n p A).card : ℝ) ≤ ε * n
```

and:

```lean
JSP001007.erdos1202_negative_public_statement_v14 :
  ¬ Erdos1202SourceStatementV14
```

## Correspondence choices

### ε and η

Both printed positive parameters are retained:

```lean
∀ ε η : ℝ, 0 < ε → 0 < η → ...
```

The displayed public problem does not otherwise use `η`.  V14 preserves it
rather than deleting it.

### k

V14 writes simply:

```lean
∃ k : ℕ, ...
```

It does not add a separate `0 < k` premise.  This avoids making the proof
depend on a convention not literally needed by the displayed source text.
The death audit formally proves that even allowing `k = 0` cannot rescue the
positive statement.

V12 had included `0 < k`; that was a reasonable reading of the notation
`p₁ < ... < p_k`, but V14 is more convention-robust.

### n

V14 makes the ordinary positive size domain explicit:

```lean
0 < n →
```

This prevents the formal target from relying on the artificial natural-number
edge case `n = 0`.  The constructed counterexample has
`n = Q * B > 0`, and the positive-`n` negative theorem was independently
compiled and kernel-checked in the closed death audit.

### Increasing primes and the size bound

`Fin k → ℕ` together with `StrictMono p` represents the increasing prime
family.

V14 states the size condition for every index:

```lean
∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)
```

For a nonempty strictly increasing family this is equivalent to bounding the
last/largest prime.  The closed audit includes a formal lemma proving that
equivalence for `Fin (k+1)`.

### Exact half-cardinality

V14 uses:

```lean
2 * (A i).card = p i - 1
```

rather than natural-number division `card = (p-1)/2`.  This expresses the
literal exact integer-cardinality condition and automatically excludes the
`p=2` truncation ambiguity.

The closed audit formally verifies that, at `p=2`,
`card = (p-1)/2` under Nat division is not equivalent to the exact equation.

### Survivor domain

Positive integers `m ≤ n` are represented by:

```lean
Finset.Icc 1 n
```

### Terminal inequality

The current public phrase "at most ε n" is represented by:

```lean
remaining.card ≤ ε * n
```

The closed audit also proves that the same construction refutes the historical
strict reading `remaining.card < ε*n`.

## Robustness to the floor-half convention

As an additional semantic stress test, the audit replaces exact half by the
Green/DeepMind-style floor convention:

```lean
(A i).card = p i / 2
```

The constructed primes are all greater than 2, hence odd, and the same
counterexample formally refutes that nearby reading as well.

## Why V14 supersedes V12 for review

V12 already had a complete kernel-checked negative theorem and the exact-half
and current-terminal fixes.  The closed death audit did **not** find a flaw in
the mathematical construction.

V14 hardens two source-domain conventions:

1. it removes the extra explicit `0 < k` premise;
2. it makes `0 < n` explicit.

The audit proves the counterexample survives both changes.  V14 is therefore
the preferred review endpoint while V12 remains preserved as historical
evidence.
