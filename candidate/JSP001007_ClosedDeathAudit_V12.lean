import Mathlib
import JSP001007_WP4Q_SourceFaithful_FinalWrapper_V12

namespace JSP001007

/-
Closed death audit for the frozen V12 proof.

This file is deliberately NOT part of the submitted theorem chain.  It attacks
statement fidelity and edge cases without modifying verified-v12.

Audit targets:
1. remove the explicit positivity requirement on k and re-prove the negative
   result (so k = 0 cannot be a loophole);
2. check that "all primes below the bound" is equivalent to a last-prime bound
   for a nonempty strictly increasing list;
3. check that the exact-half equation excludes p = 2 and differs from truncated
   Nat division there;
4. record positivity of the constructed n.
-/

def Erdos1202SourceStatementNoKPosAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i,
          (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV12 n p A).card : ℝ) ≤ ε * n

theorem erdos1202_negative_no_kpos_audit :
    ¬ Erdos1202SourceStatementNoKPosAudit := by
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
      ((remaining1202SourceV12 n p A).card : ℝ) ≤ (n : ℝ) / 3 := by
    nlinarith

  have hlarge' :
      (n : ℝ) / 3 <
        ((remaining1202SourceV12 n p A).card : ℝ) := by
    simpa [remaining1202SourceV12] using hlarge

  exact (not_lt_of_ge hbad') hlarge'

lemma strictMono_all_lt_iff_last_lt_audit
    {k : ℕ} (p : Fin (k + 1) → ℕ) (hmono : StrictMono p) (R : ℝ) :
    (∀ i, (p i : ℝ) < R) ↔ ((p (Fin.last k) : ℝ) < R) := by
  constructor
  · intro h
    exact h (Fin.last k)
  · intro hlast i
    have hleFin : i ≤ Fin.last k := Fin.le_last i
    have hleNat : p i ≤ p (Fin.last k) := hmono.monotone hleFin
    have hleReal : (p i : ℝ) ≤ (p (Fin.last k) : ℝ) := by
      exact_mod_cast hleNat
    exact hleReal.trans_lt hlast

lemma exact_half_excludes_two_audit
    {p : ℕ} {A : Finset (ZMod p)}
    (hhalf : 2 * A.card = p - 1) :
    p ≠ 2 := by
  intro hp
  subst p
  omega

example :
    ∃ A : Finset (ZMod 2),
      A.card = (2 - 1) / 2 ∧
      ¬ (2 * A.card = 2 - 1) := by
  refine ⟨∅, ?_, ?_⟩ <;> norm_num

lemma constructed_n_positive_audit
    {k : ℕ} (D : ClusterData k) :
    0 < D.n := by
  exact Nat.mul_pos D.hQpos D.hBpos

#print axioms erdos1202_negative_no_kpos_audit

end JSP001007
