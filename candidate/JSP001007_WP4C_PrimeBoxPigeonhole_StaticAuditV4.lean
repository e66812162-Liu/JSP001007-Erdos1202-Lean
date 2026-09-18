import Mathlib

namespace JSP001007

/-
WP4-G static audit V4: pure finite prime-box pigeonhole layer.

Main change:
* the strong pigeonhole theorem is now called with explicit `(s,t,f,n)` arguments;
* the range-card identity is normalized before the call, avoiding elaboration
  dependence on simp during argument matching.

IMPORTANT: not Lean-kernel compiled in this environment.
-/

def boxIndexV4 (M H p : ℕ) : ℕ :=
  (p - M - 1) / H

lemma boxIndexV4_mem_range
    {M H J p : ℕ}
    (hH : 0 < H)
    (hMH : M = J * H)
    (hpL : M < p)
    (hpU : p ≤ 2 * M) :
    boxIndexV4 M H p ∈ Finset.range J := by
  rw [Finset.mem_range]
  unfold boxIndexV4
  apply (Nat.div_lt_iff_lt_mul hH).2
  have hu : p - M - 1 < M := by omega
  simpa [hMH] using hu

lemma boxIndexV4_bounds
    {M H p j : ℕ}
    (hH : 0 < H)
    (hpL : M < p)
    (hbox : boxIndexV4 M H p = j) :
    M + j * H < p ∧ p ≤ M + (j + 1) * H := by
  have hdiv : (p - M - 1) / H = j := by
    simpa [boxIndexV4] using hbox
  have hlow0 := Nat.div_mul_le_self (p - M - 1) H
  rw [hdiv] at hlow0
  have hlow : j * H ≤ p - M - 1 := hlow0
  have hupp_pair := (Nat.div_eq_iff hH).1 hdiv
  have hupp : p - M - 1 ≤ j * H + H - 1 := hupp_pair.2
  constructor
  · omega
  · calc
      p ≤ M + (j * H + H) := by omega
      _ = M + (j + 1) * H := by ring

def boxFiberV4 (s : Finset ℕ) (M H j : ℕ) : Finset ℕ :=
  s.filter (fun p => boxIndexV4 M H p = j)

theorem exists_dense_box_v4
    {M H J k : ℕ}
    (hH : 0 < H)
    (hJ : 0 < J)
    (hMH : M = J * H)
    (s : Finset ℕ)
    (hs : ∀ p ∈ s, M < p ∧ p ≤ 2 * M)
    (hcard : J * k ≤ s.card) :
    ∃ j < J,
      k ≤ (boxFiberV4 s M H j).card ∧
      ∀ p ∈ boxFiberV4 s M H j,
        M + j * H < p ∧ p ≤ M + (j + 1) * H := by
  let tbox : Finset ℕ := Finset.range J
  let f : ℕ → ℕ := boxIndexV4 M H

  have hmap : ∀ p ∈ s, f p ∈ tbox := by
    intro p hp
    exact boxIndexV4_mem_range hH hMH (hs p hp).1 (hs p hp).2

  have hnonempty : tbox.Nonempty := by
    dsimp [tbox]
    exact Finset.nonempty_range_iff.mpr (Nat.ne_of_gt hJ)

  have hcard' : tbox.card * k ≤ s.card := by
    simpa [tbox] using hcard

  obtain ⟨j, hjmem, hjcard⟩ :=
    Finset.exists_le_card_fiber_of_mul_le_card_of_maps_to
      (s := s) (t := tbox) (f := f) (n := k)
      hmap hnonempty hcard'

  have hj : j < J := by
    simpa [tbox] using hjmem

  refine ⟨j, hj, ?_, ?_⟩
  · simpa [boxFiberV4, f] using hjcard
  · intro p hp
    have hp' := Finset.mem_filter.mp hp
    exact boxIndexV4_bounds hH (hs p hp'.1).1 hp'.2

end JSP001007
