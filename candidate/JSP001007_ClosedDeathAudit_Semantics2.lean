import Mathlib
import JSP001007_ClosedDeathAudit_V12

namespace JSP001007

/-
Second semantic attack pass.

This module checks robustness against two nearby readings:
* historical strict terminal inequality < ε*n;
* the Green-44 convention floor(p/2) for "half" the residue classes.

Both are refuted by the same cluster construction.
-/

def Erdos1202StrictTerminalAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV12 n p A).card : ℝ) < ε * n

theorem erdos1202_negative_strict_terminal_audit :
    ¬ Erdos1202StrictTerminalAudit := by
  intro hstrict
  apply erdos1202_negative_no_kpos_audit
  intro ε η hε hη
  obtain ⟨k, hk⟩ := hstrict ε η hε hη
  refine ⟨k, ?_⟩
  intro n p A hp hmono hsmall hhalf
  exact le_of_lt (hk n p A hp hmono hsmall hhalf)

lemma ClusterData.A_card_floor_half_audit
    {k : ℕ} (D : ClusterData k) :
    ∀ i, (D.A i).card = D.p i / 2 := by
  intro i
  rw [D.A_card i]
  have hpne2 : D.p i ≠ 2 := by
    have := D.p_gt_two i
    omega
  have heven : Even (D.p i - 1) :=
    (D.p_prime i).even_sub_one hpne2
  rcases heven with ⟨u, hu⟩
  omega

def Erdos1202FloorHalfAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ,
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, (A i).card = p i / 2) →
        ((remaining1202SourceV12 n p A).card : ℝ) ≤ ε * n

theorem erdos1202_negative_floor_half_audit :
    ¬ Erdos1202FloorHalfAudit := by
  intro hmain

  obtain ⟨k, hk⟩ :=
    hmain ((1 : ℝ) / 3) 1 (by norm_num) (by norm_num)

  obtain ⟨D, _⟩ := clusterData_arch51_exists k

  let n := D.n
  let p := D.p
  let A := D.A

  have hp : ∀ i, (p i).Prime := by
    intro i
    exact D.p_prime i

  have hmono : StrictMono p := D.p_strictMono

  have hsmall :
      ∀ i, (p i : ℝ) <
        Real.rpow (n : ℝ) (1 - (1 : ℝ) / 3) := by
    intro i
    have h23 :
        (p i : ℝ) < Real.rpow (n : ℝ) ((2 : ℝ) / 3) := by
      exact cube_lt_square_to_rpow_two_thirds_kernel
        (D.hpow (D.p i) (D.p_mem i))
    simpa only [show (1 : ℝ) - 1 / 3 = 2 / 3 by norm_num] using h23

  have hfloor : ∀ i, (A i).card = p i / 2 := by
    intro i
    exact D.A_card_floor_half_audit i

  have hbad := hk n p A hp hmono hsmall hfloor

  have hlargeNat : D.n < 3 * D.remaining.card := D.remaining_large
  have hlarge :
      (n : ℝ) / 3 <
        ((remaining1202SourceV12 n p A).card : ℝ) := by
    have hreal : (D.n : ℝ) < 3 * (D.remaining.card : ℝ) := by
      exact_mod_cast hlargeNat
    dsimp [n, p, A]
    simpa [remaining1202SourceV12, ClusterData.remaining] using
      (show (D.n : ℝ) / 3 < D.remaining.card by nlinarith)

  have hbad' :
      ((remaining1202SourceV12 n p A).card : ℝ) ≤ (n : ℝ) / 3 := by
    nlinarith

  exact (not_lt_of_ge hbad') hlarge

#print axioms erdos1202_negative_strict_terminal_audit
#print axioms erdos1202_negative_floor_half_audit

end JSP001007
