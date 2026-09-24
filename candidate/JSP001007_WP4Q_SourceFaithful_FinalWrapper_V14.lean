import Mathlib
import JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4

namespace JSP001007

/-
V14 candidate: closed-death-audit hardened source wrapper.

Relative to V12:
* do not impose an extra positivity convention on k;
* explicitly restrict the size parameter to positive n, matching the ordinary
  mathematical domain of [1,n];
* retain the current public "at most ε n" conclusion;
* retain literal exact half-cardinality as 2 * card = p - 1.

This makes the positive proposition weaker/easier to satisfy than V12 in both
domain-convention respects. Its negation is therefore a stronger and safer
counterexample theorem.
-/

def remaining1202SourceV14
    {k : ℕ} (n : ℕ) (p : Fin k → ℕ)
    (A : (i : Fin k) → Finset (ZMod (p i))) : Finset ℕ :=
  (Finset.Icc 1 n).filter (fun m => ∀ i, (m : ZMod (p i)) ∉ A i)

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

theorem erdos1202_negative_public_statement_v14 :
    ¬ Erdos1202SourceStatementV14 := by
  intro hmain

  obtain ⟨k, hk⟩ :=
    hmain ((1 : ℝ) / 3) 1 (by norm_num) (by norm_num)

  obtain ⟨D, _⟩ := clusterData_arch51_exists k

  let n : ℕ := D.n
  let p : Fin k → ℕ := D.p
  let A : (i : Fin k) → Finset (ZMod (p i)) := D.A

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
        (D.p i : ℝ) <
          Real.rpow (D.n : ℝ) ((2 : ℝ) / 3) :=
      cube_lt_square_to_rpow_two_thirds_kernel
        (D.hpow (D.p i) (D.p_mem i))
    change
      (D.p i : ℝ) <
        Real.rpow (D.n : ℝ) (1 - (1 : ℝ) / 3)
    rw [show (1 : ℝ) - 1 / 3 = 2 / 3 by norm_num]
    exact h23

  have hcard : ∀ i, 2 * (A i).card = p i - 1 := by
    intro i
    exact D.A_card_exact_half i

  have hbad := hk n p A hnpos hp hmono hsmall hcard

  have hlargeNat : D.n < 3 * D.remaining.card := D.remaining_large

  have hlarge :
      (n : ℝ) / 3 <
        ((remaining1202SourceV14 n p A).card : ℝ) := by
    have hreal : (D.n : ℝ) < 3 * (D.remaining.card : ℝ) := by
      exact_mod_cast hlargeNat
    dsimp [n, p, A]
    simpa [remaining1202SourceV14, ClusterData.remaining] using
      (show (D.n : ℝ) / 3 < D.remaining.card by nlinarith)

  have hbad' :
      ((remaining1202SourceV14 n p A).card : ℝ) ≤ (n : ℝ) / 3 := by
    nlinarith

  exact (not_lt_of_ge hbad') hlarge

end JSP001007
