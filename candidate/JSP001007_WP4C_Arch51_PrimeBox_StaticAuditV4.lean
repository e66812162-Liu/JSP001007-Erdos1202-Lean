import Mathlib
import JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4

namespace JSP001007

lemma arch51_partition_identity_v4 (t : ℕ) :
    400 * t^4 = (400 * t^2) * t^2 := by
  ring

theorem arch51_dense_interval_v4
    {t k : ℕ}
    (ht : 0 < t)
    (hteven : Even t)
    (s : Finset ℕ)
    (hs : ∀ p ∈ s, 400 * t^4 < p ∧ p ≤ 800 * t^4)
    (hcard : (400 * t^2) * k ≤ s.card) :
    ∃ B : ℕ,
      400 * t^4 ≤ B ∧
      B + t^2 ≤ 800 * t^4 ∧
      Even B ∧
      k ≤ (s.filter (fun p => B < p ∧ p ≤ B + t^2)).card := by
  have hH : 0 < t^2 := by positivity
  have hJ : 0 < 400 * t^2 := by positivity
  have hMH : 400 * t^4 = (400 * t^2) * t^2 :=
    arch51_partition_identity_v4 t

  have hs' :
      ∀ p ∈ s, 400 * t^4 < p ∧ p ≤ 2 * (400 * t^4) := by
    intro p hp
    have h := hs p hp
    constructor
    · exact h.1
    · calc
        p ≤ 800 * t^4 := h.2
        _ = 2 * (400 * t^4) := by ring

  obtain ⟨j, hj, hjcard, hjbounds⟩ :=
    exists_dense_box_v4
      (M := 400 * t^4)
      (H := t^2)
      (J := 400 * t^2)
      (k := k)
      hH hJ hMH s hs' hcard

  let B : ℕ := 400 * t^4 + j * t^2

  have hMeven : Even (400 * t^4) := by
    refine ⟨200 * t^4, ?_⟩
    ring

  have hHeven : Even (t^2) := by
    rcases hteven with ⟨u, hu⟩
    refine ⟨2 * u^2, ?_⟩
    rw [hu]
    ring

  have hBeven : Even B := by
    rcases hMeven with ⟨a, ha⟩
    rcases hHeven with ⟨b, hb⟩
    refine ⟨a + j * b, ?_⟩
    dsimp [B]
    rw [ha, hb]
    ring

  refine ⟨B, ?_, ?_, hBeven, ?_⟩
  · simp [B]
  · have hj' : j + 1 ≤ 400 * t^2 := by omega
    dsimp [B]
    calc
      400 * t^4 + j * t^2 + t^2
          = 400 * t^4 + (j + 1) * t^2 := by ring
      _ ≤ 400 * t^4 + (400 * t^2) * t^2 := by gcongr
      _ = 800 * t^4 := by ring
  · have hsubset :
        boxFiberV4 s (400 * t^4) (t^2) j ⊆
          s.filter (fun p => B < p ∧ p ≤ B + t^2) := by
      intro p hp
      have hb := hjbounds p hp
      have hps := (Finset.mem_filter.mp hp).1
      rw [Finset.mem_filter]
      refine ⟨hps, ?_⟩
      constructor
      · simpa [B] using hb.1
      · calc
          p ≤ 400 * t^4 + (j + 1) * t^2 := hb.2
          _ = B + t^2 := by
            dsimp [B]
            ring
    exact le_trans hjcard (Finset.card_le_card hsubset)

end JSP001007
