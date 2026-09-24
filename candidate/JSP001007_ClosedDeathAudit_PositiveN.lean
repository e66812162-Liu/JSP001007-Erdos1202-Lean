import Mathlib
import JSP001007_ClosedDeathAudit_V12

namespace JSP001007

/-
Third closed death-audit pass: source-domain positivity of n.

The published problem treats n as the size parameter of [1,n], hence a positive
integer is the natural source domain.  V12/V13 quantify over every Nat n,
including 0.  That makes the positive conjecture formally stronger, so a bare
negation of that formulation would not by itself rule out a positive-n-only
reading.

This audit proves the negative result again with an explicit 0 < n premise.
The counterexample uses n = Q*B with Q,B > 0, so the mathematical construction
already supplies the needed positivity.
-/

def Erdos1202PositiveNSourceAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        0 < n →
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV12 n p A).card : ℝ) ≤ ε * n

theorem erdos1202_negative_positive_n_audit :
    ¬ Erdos1202PositiveNSourceAudit := by
  intro hmain

  obtain ⟨k, hk⟩ :=
    hmain ((1 : ℝ) / 3) 1 (by norm_num) (by norm_num)

  obtain ⟨D, _⟩ := clusterData_arch51_exists k

  let n := D.n
  let p := D.p
  let A := D.A

  have hnpos : 0 < n := by
    dsimp [n, ClusterData.n]
    exact Nat.mul_pos D.hQpos D.hBpos

  have hp : ∀ i, (p i).Prime := by
    intro i
    exact D.p_prime i

  have hmono : StrictMono p := D.p_strictMono

  have hsmall :
      ∀ i,
        (p i : ℝ) <
          Real.rpow (n : ℝ) (1 - (1 : ℝ) / 3) := by
    intro i
    have h23 :
        (p i : ℝ) < Real.rpow (n : ℝ) ((2 : ℝ) / 3) := by
      exact cube_lt_square_to_rpow_two_thirds_kernel
        (D.hpow (D.p i) (D.p_mem i))
    simpa only [show (1 : ℝ) - 1 / 3 = 2 / 3 by norm_num] using h23

  have hcard : ∀ i, 2 * (A i).card = p i - 1 := by
    intro i
    exact D.A_card_exact_half i

  have hbad := hk n p A hnpos hp hmono hsmall hcard

  have hNat : D.n < 3 * D.remaining.card := D.remaining_large
  have hReal : (D.n : ℝ) < 3 * (D.remaining.card : ℝ) := by
    exact_mod_cast hNat

  have hlarge :
      (n : ℝ) / 3 <
        ((remaining1202SourceV12 n p A).card : ℝ) := by
    dsimp [n, p, A]
    simpa [remaining1202SourceV12, ClusterData.remaining] using
      (show (D.n : ℝ) / 3 < D.remaining.card by nlinarith)

  have hbad' :
      ((remaining1202SourceV12 n p A).card : ℝ) ≤ (n : ℝ) / 3 := by
    nlinarith

  exact (not_lt_of_ge hbad') hlarge

def Erdos1202HistoricalPositiveNAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        0 < n →
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV12 n p A).card : ℝ) < ε * n

theorem erdos1202_negative_historical_positive_n_audit :
    ¬ Erdos1202HistoricalPositiveNAudit := by
  intro hstrict
  apply erdos1202_negative_positive_n_audit
  intro ε η hε hη
  obtain ⟨k, hk⟩ := hstrict ε η hε hη
  refine ⟨k, ?_⟩
  intro n p A hn hp hmono hsmall hhalf
  exact le_of_lt (hk n p A hn hp hmono hsmall hhalf)

#print axioms erdos1202_negative_positive_n_audit
#print axioms erdos1202_negative_historical_positive_n_audit

end JSP001007
