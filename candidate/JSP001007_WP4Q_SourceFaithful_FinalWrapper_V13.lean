import Mathlib
import JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4

namespace JSP001007

/-
V13 candidate produced by the closed death audit.

Compared with V12, the explicit premise `0 < k` is removed from the source
statement.  The current public wording says only "does there exist a k".
Allowing k = 0 makes the positive statement weaker, so proving its negation is
strictly more robust and eliminates any convention dispute about whether k was
implicitly required to be positive.

All other source-fidelity choices of V12 are retained:
* positive ε and η;
* ordered prime family via StrictMono;
* all primes below n^(1-ε);
* literal exact half-cardinality via 2 * card = p - 1;
* positive integers [1,n];
* "at most ε n" as ≤ ε*n.

The same mathematical construction works for every natural k, including k = 0.
-/

def remaining1202SourceV13
    {k : ℕ} (n : ℕ) (p : Fin k → ℕ)
    (A : (i : Fin k) → Finset (ZMod (p i))) : Finset ℕ :=
  (Finset.Icc 1 n).filter (fun m => ∀ i, (m : ZMod (p i)) ∉ A i)

def Erdos1202SourceStatementV13 : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i,
          (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV13 n p A).card : ℝ) ≤ ε * n

theorem erdos1202_negative_public_statement_v13 :
    ¬ Erdos1202SourceStatementV13 := by
  intro hmain

  obtain ⟨k, hk⟩ :=
    hmain ((1 : ℝ) / 3) 1 (by norm_num) (by norm_num)

  obtain ⟨D, _⟩ := clusterData_arch51_exists k

  obtain ⟨n, p, A, hp, hmono, hsmall, hcard, hlarge⟩ :=
    counterexample_at_third_of_clusterData_exact D

  have hsmall' :
      ∀ i,
        (p i : ℝ) <
          Real.rpow (n : ℝ) (1 - (1 : ℝ) / 3) := by
    intro i
    simpa only [show (1 : ℝ) - 1 / 3 = 2 / 3 by norm_num] using
      hsmall i

  have hbad := hk n p A hp hmono hsmall' hcard

  have hbad' :
      ((remaining1202SourceV13 n p A).card : ℝ) ≤ (n : ℝ) / 3 := by
    nlinarith

  have hlarge' :
      (n : ℝ) / 3 <
        ((remaining1202SourceV13 n p A).card : ℝ) := by
    simpa [remaining1202SourceV13] using hlarge

  exact (not_lt_of_ge hbad') hlarge'

end JSP001007
