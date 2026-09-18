import Mathlib
import JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4

namespace JSP001007

/-
WP4-P V11 modular final wrapper.

The proof is factored as:

  PNT -> ClusterData -> pure-Mathlib counterexample -> negation of source statement.

The final statement uses:
* positive k;
* exact half-cardinality `2 * card = p - 1`;
* the primary-source strict `< εn`;
* the printed but unused η quantifier.

IMPORTANT: first real Lean build is performed by repository CI.
-/

def remaining1202SourceV11
    {k : ℕ} (n : ℕ) (p : Fin k → ℕ)
    (A : (i : Fin k) → Finset (ZMod (p i))) : Finset ℕ :=
  (Finset.Icc 1 n).filter (fun m => ∀ i, (m : ZMod (p i)) ∉ A i)

def Erdos1202SourceStatementV11 : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ, 0 < k ∧
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i,
          (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV11 n p A).card : ℝ) < ε * n

theorem erdos1202_negative_source_faithful_v11 :
    ¬ Erdos1202SourceStatementV11 := by
  intro hmain

  obtain ⟨k, hkpos, hk⟩ :=
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
      ((remaining1202SourceV11 n p A).card : ℝ) < (n : ℝ) / 3 := by
    nlinarith

  have hlarge' :
      (n : ℝ) / 3 <
        ((remaining1202SourceV11 n p A).card : ℝ) := by
    simpa [remaining1202SourceV11] using hlarge

  exact (not_lt_of_ge hlarge'.le) hbad'

end JSP001007
