import Mathlib
import JSP001007_WP4Q_SourceFaithful_FinalWrapper_V12
import JSP001007_WP4Q_SourceFaithful_FinalWrapper_V14

namespace JSP001007

/-
Closed death audit, bridge pass.

This module formalizes the proposition-strength relations used to justify V14
as a conservative/harder-to-refute review target.

1. V12 -> V14: any witness satisfying the stronger V12 positive proposition
   also satisfies V14 (reuse the same positive k and restrict to n > 0).
   Therefore ¬V14 is at least as strong a negative result as ¬V12.

2. A source reading that explicitly requires both k > 0 and n > 0 also implies
   V14.  Therefore the V14 negation refutes that conventional reading too.
-/

theorem v12_implies_v14_audit :
    Erdos1202SourceStatementV12 → Erdos1202SourceStatementV14 := by
  intro h12 ε η hε hη
  obtain ⟨k, hkpos, hk⟩ := h12 ε η hε hη
  refine ⟨k, ?_⟩
  intro n p A hn hp hmono hsmall hhalf
  have h :=
    hk n p A hp hmono hsmall hhalf
  simpa [remaining1202SourceV12, remaining1202SourceV14] using h

def Erdos1202PositiveKPositiveNSourceAudit : Prop :=
  ∀ ε η : ℝ, 0 < ε → 0 < η →
    ∃ k : ℕ, 0 < k ∧
      ∀ (n : ℕ) (p : Fin k → ℕ)
        (A : (i : Fin k) → Finset (ZMod (p i))),
        0 < n →
        (∀ i, (p i).Prime) →
        StrictMono p →
        (∀ i,
          (p i : ℝ) < Real.rpow (n : ℝ) (1 - ε)) →
        (∀ i, 2 * (A i).card = p i - 1) →
        ((remaining1202SourceV14 n p A).card : ℝ) ≤ ε * n

theorem positive_k_positive_n_implies_v14_audit :
    Erdos1202PositiveKPositiveNSourceAudit → Erdos1202SourceStatementV14 := by
  intro hsrc ε η hε hη
  obtain ⟨k, hkpos, hk⟩ := hsrc ε η hε hη
  exact ⟨k, hk⟩

theorem erdos1202_negative_positive_k_positive_n_bridge_audit :
    ¬ Erdos1202PositiveKPositiveNSourceAudit := by
  intro hsrc
  exact erdos1202_negative_public_statement_v14
    (positive_k_positive_n_implies_v14_audit hsrc)

#print axioms v12_implies_v14_audit
#print axioms erdos1202_negative_positive_k_positive_n_bridge_audit

end JSP001007
