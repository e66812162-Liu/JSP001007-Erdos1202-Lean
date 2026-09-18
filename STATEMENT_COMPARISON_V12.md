# Statement comparison — JSP-001007 / Erdős #1202

Date: 2026-09-17

## Public target

The current public Erdős Problems statement asks whether, for every positive
`ε, η`, there exists a positive number `k` such that for any increasing
list of `k` primes below `n^(1-ε)`, after choosing exactly
`(p_i-1)/2` residue classes modulo each prime, the number of positive
integers `m ≤ n` avoiding every forbidden class is **at most `ε n`**.

The displayed `η` is present in the public statement but does not occur again
in its hypotheses or conclusion. V12 preserves that printed quantifier.

## Lean target

V12 formalizes the public target as:

```lean
def Erdos1202SourceStatementV12 : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ, 0 < k ∧
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV12 n p A).card : ℝ) ≤ ε * n
```

and proves:

```lean
erdos1202_negative_public_statement_v12 :
  ¬ Erdos1202SourceStatementV12
```

## Correspondence notes

- `Fin k → ℕ` with `StrictMono p` represents
  `p₁ < ⋯ < p_k`.
- The public bound on the largest prime is represented by the equivalent
  all-index bound because `k>0` and the list is strictly increasing.
- Positive integers `m ≤ n` are represented by `Finset.Icc 1 n`.
- Residue classes are finite subsets of `ZMod (p i)`.
- Exact half-cardinality is written as
  `2 * (A i).card = p i - 1`.  This avoids truncated natural-number division
  and expresses the ordinary integer meaning of `(p_i-1)/2`.
- The phrase "at most ε n" is represented by `≤ ε * n`.
- The public `η` quantifier is preserved even though it is unused in the
  displayed public statement.

## Why V12 supersedes V11 for external review

V11 used a strict terminal inequality `< ε*n`.  Its counterexample proof was
already strong enough to contradict the non-strict public wording because it
constructs strictly more than `n/3` survivors at `ε=1/3`.

V12 therefore changes only the target statement and the final contradiction;
the prime-cluster construction and all substantive proof modules are unchanged.

This comparison is a statement-correspondence aid for maintainer review, not a
claim of mathematical discovery or priority.
