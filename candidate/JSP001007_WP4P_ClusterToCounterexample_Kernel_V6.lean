import Mathlib
import JSP001007_ClusterGapEngine1202_Candidate

namespace JSP001007

/-
WP4-P V6: Pure-Mathlib dependency cut.

This module isolates the entire counterexample construction after a prime cluster
has already been supplied. It has no PNT / PrimeGapsLib dependency.

The external analytic layer therefore only needs to construct `ClusterData k`.
Everything from a short prime cluster to the ε = 1/3 counterexample is handled
here.

V6 hardening: all nonstandard `omega [..]` calls have been removed.

IMPORTANT: first real Lean build is performed by repository CI.
-/

structure ClusterData (k : ℕ) where
  B : ℕ
  H : ℕ
  Q : ℕ
  P : Finset ℕ
  hkP : k ≤ P.card
  hprime : ∀ p ∈ P, p.Prime
  hcluster : ∀ p ∈ P, B < p ∧ p ≤ B + H
  hBpos : 0 < B
  hHpos : 0 < H
  hQpos : 0 < Q
  hQgt1 : 1 < Q
  hBeven : Even B
  hLsmall : 6 * ((Q - 1) * H) < B
  hpow : ∀ p ∈ P, p^3 < (Q * B)^2

def ClusterData.p {k : ℕ} (D : ClusterData k) : Fin k → ℕ :=
  ⇑(D.P.orderEmbOfCardLe D.hkP)

def ClusterData.A {k : ℕ} (D : ClusterData k)
    (i : Fin k) : Finset (ZMod (D.p i)) :=
  deletedBlock1202 D.B (D.p i)

def ClusterData.n {k : ℕ} (D : ClusterData k) : ℕ :=
  D.Q * D.B

def ClusterData.remaining {k : ℕ} (D : ClusterData k) : Finset ℕ :=
  (Finset.Icc 1 D.n).filter
    (fun x => ∀ i, (x : ZMod (D.p i)) ∉ D.A i)

lemma ClusterData.p_mem {k : ℕ} (D : ClusterData k) (i : Fin k) :
    D.p i ∈ D.P := by
  simpa [ClusterData.p] using D.P.orderEmbOfCardLe_mem D.hkP i

lemma ClusterData.p_prime {k : ℕ} (D : ClusterData k) :
    ∀ i, (D.p i).Prime := by
  intro i
  exact D.hprime (D.p i) (D.p_mem i)

lemma ClusterData.p_strictMono {k : ℕ} (D : ClusterData k) :
    StrictMono D.p := by
  exact (D.P.orderEmbOfCardLe D.hkP).strictMono

lemma ClusterData.p_cluster {k : ℕ} (D : ClusterData k) :
    ∀ i, D.B < D.p i ∧ D.p i ≤ D.B + D.H := by
  intro i
  exact D.hcluster (D.p i) (D.p_mem i)

lemma ClusterData.A_card {k : ℕ} (D : ClusterData k) :
    ∀ i, (D.A i).card = (D.p i - 1) / 2 := by
  intro i
  exact deletedBlock1202_card (D.p_cluster i).1

lemma ClusterData.p_gt_two {k : ℕ} (D : ClusterData k) :
    ∀ i, 2 < D.p i := by
  intro i
  have hQm1pos : 0 < D.Q - 1 := by
    have hQgt1 := D.hQgt1
    omega
  have hLpos : 0 < (D.Q - 1) * D.H :=
    Nat.mul_pos hQm1pos D.hHpos
  have hsmall := D.hLsmall
  have hBgt : 2 < D.B := by
    omega
  exact lt_trans hBgt (D.p_cluster i).1

lemma ClusterData.A_card_exact_half {k : ℕ} (D : ClusterData k) :
    ∀ i, 2 * (D.A i).card = D.p i - 1 := by
  intro i
  rw [D.A_card i]
  have hpgt2 := D.p_gt_two i
  have hpne2 : D.p i ≠ 2 := by
    omega
  have heven : Even (D.p i - 1) :=
    (D.p_prime i).even_sub_one hpne2
  rcases heven with ⟨u, hu⟩
  omega

lemma cube_lt_square_to_rpow_two_thirds_kernel
    {p n : ℕ} (h : p^3 < n^2) :
    (p : ℝ) < Real.rpow (n : ℝ) ((2 : ℝ) / 3) := by
  let y : ℝ := Real.rpow (n : ℝ) ((2 : ℝ) / 3)
  have hn0 : (0 : ℝ) ≤ n := by positivity
  have hy0 : 0 ≤ y := by
    dsimp [y]
    exact Real.rpow_nonneg hn0 _

  have hr := Real.rpow_mul hn0 ((2 : ℝ) / 3) (3 : ℝ)

  have hycube : y ^ (3 : ℕ) = (n : ℝ) ^ (2 : ℕ) := by
    calc
      y ^ (3 : ℕ)
          = Real.rpow y (3 : ℝ) := by
              symm
              simpa using Real.rpow_natCast y 3
      _ = Real.rpow (n : ℝ) (((2 : ℝ) / 3) * 3) := by
              dsimp [y]
              exact hr.symm
      _ = Real.rpow (n : ℝ) (2 : ℝ) := by norm_num
      _ = (n : ℝ) ^ (2 : ℕ) := by
              simpa using Real.rpow_natCast (n : ℝ) 2

  have hcast :
      (p : ℝ) ^ (3 : ℕ) < (n : ℝ) ^ (2 : ℕ) := by
    exact_mod_cast h

  have hpowy :
      (p : ℝ) ^ (3 : ℕ) < y ^ (3 : ℕ) := by
    rw [hycube]
    exact hcast

  exact lt_of_pow_lt_pow_left₀ 3 hy0 hpowy

lemma ClusterData.rectangle_subset_remaining
    {k : ℕ} (D : ClusterData k) :
    rectangle1202 D.B D.H D.Q ⊆ D.remaining := by
  intro x hx
  have hx' :
      x ∈ (pairBox1202 D.B D.H D.Q).image (encode1202 D.B) := by
    simpa [rectangle1202] using hx
  rcases Finset.mem_image.mp hx' with ⟨qr, hqr, henc⟩
  rcases qr with ⟨q, r⟩
  change q * D.B + r = x at henc
  subst x
  simp [pairBox1202] at hqr
  rcases hqr with ⟨hq, hrlo, hrhi⟩
  change q * D.B + r ∈
    (Finset.Icc 1 D.n).filter
      (fun y => ∀ i, (y : ZMod (D.p i)) ∉ D.A i)
  rw [Finset.mem_filter]
  constructor
  · rw [Finset.mem_Icc]
    constructor
    · have hQm1pos : 0 < D.Q - 1 := by
        have hQgt1 := D.hQgt1
        omega
      have hLpos : 0 < (D.Q - 1) * D.H :=
        Nat.mul_pos hQm1pos D.hHpos
      have hrpos : 0 < r := lt_of_lt_of_le hLpos hrlo
      omega
    · have hqsucc : q + 1 ≤ D.Q := by omega
      have hrB : r < D.B := by omega
      have hxlt : q * D.B + r < (q + 1) * D.B := by
        calc
          q * D.B + r < q * D.B + D.B := Nat.add_lt_add_left hrB _
          _ = (q + 1) * D.B := by ring
      have hle : (q + 1) * D.B ≤ D.Q * D.B :=
        Nat.mul_le_mul_right D.B hqsucc
      have hxle : q * D.B + r ≤ D.Q * D.B :=
        Nat.le_of_lt (hxlt.trans_le hle)
      simpa [ClusterData.n] using hxle
  · intro i
    simpa [ClusterData.A] using
      (clusterGap_avoids_deletedBlock1202
        (B := D.B) (H := D.H) (Q := D.Q)
        (p := D.p i) (q := q) (r := r)
        (D.p_cluster i).1 (D.p_cluster i).2 hq hrlo hrhi)

lemma ClusterData.rectangle_large {k : ℕ} (D : ClusterData k) :
    D.n < 3 * (rectangle1202 D.B D.H D.Q).card := by
  have hhalf : D.B = 2 * (D.B / 2) := by
    rcases D.hBeven with ⟨u, hu⟩
    omega

  have hsmall := D.hLsmall
  have h6Lhalf :
      6 * ((D.Q - 1) * D.H) < 2 * (D.B / 2) := by
    calc
      6 * ((D.Q - 1) * D.H) < D.B := D.hLsmall
      _ = 2 * (D.B / 2) := hhalf

  have h3L :
      3 * ((D.Q - 1) * D.H) < D.B / 2 := by
    omega
  have hLle :
      (D.Q - 1) * D.H ≤ D.B / 2 := by
    omega
  have hdecomp :
      (D.Q - 1) * D.H +
          (D.B / 2 - (D.Q - 1) * D.H) =
        D.B / 2 :=
    Nat.add_sub_of_le hLle

  have hinner :
      D.B < 3 * (D.B / 2 - (D.Q - 1) * D.H) := by
    omega

  have hcard :
      (rectangle1202 D.B D.H D.Q).card =
        D.Q * (D.B / 2 - (D.Q - 1) * D.H) :=
    rectangle1202_card D.hBpos

  rw [hcard]
  dsimp [ClusterData.n]
  have hmul :
      D.Q * D.B <
        D.Q * (3 * (D.B / 2 - (D.Q - 1) * D.H)) :=
    Nat.mul_lt_mul_of_pos_left hinner D.hQpos
  simpa [mul_assoc, mul_left_comm, mul_comm] using hmul

lemma ClusterData.remaining_large {k : ℕ} (D : ClusterData k) :
    D.n < 3 * D.remaining.card := by
  have hc :
      (rectangle1202 D.B D.H D.Q).card ≤ D.remaining.card :=
    Finset.card_le_card D.rectangle_subset_remaining
  have h3c :
      3 * (rectangle1202 D.B D.H D.Q).card
        ≤ 3 * D.remaining.card :=
    Nat.mul_le_mul_left 3 hc
  exact D.rectangle_large.trans_le h3c

theorem counterexample_at_third_of_clusterData
    {k : ℕ} (D : ClusterData k) :
    ∃ (n : ℕ) (p : Fin k → ℕ)
      (A : (i : Fin k) → Finset (ZMod (p i))),
      (∀ i, (p i).Prime) ∧
      StrictMono p ∧
      (∀ i,
        (p i : ℝ) < Real.rpow (n : ℝ) ((2 : ℝ) / 3)) ∧
      (∀ i, (A i).card = (p i - 1) / 2) ∧
      ((n : ℝ) / 3 <
        (((Finset.Icc 1 n).filter
          (fun x => ∀ i, (x : ZMod (p i)) ∉ A i)).card : ℝ)) := by
  refine ⟨D.n, D.p, D.A, D.p_prime, D.p_strictMono, ?_, D.A_card, ?_⟩
  · intro i
    exact cube_lt_square_to_rpow_two_thirds_kernel
      (D.hpow (D.p i) (D.p_mem i))
  · have hNat : D.n < 3 * D.remaining.card := D.remaining_large
    have hReal :
        (D.n : ℝ) < 3 * (D.remaining.card : ℝ) := by
      exact_mod_cast hNat
    simpa [ClusterData.remaining] using (show (D.n : ℝ) / 3 < D.remaining.card by
      nlinarith)

theorem counterexample_at_third_of_clusterData_exact
    {k : ℕ} (D : ClusterData k) :
    ∃ (n : ℕ) (p : Fin k → ℕ)
      (A : (i : Fin k) → Finset (ZMod (p i))),
      (∀ i, (p i).Prime) ∧
      StrictMono p ∧
      (∀ i,
        (p i : ℝ) < Real.rpow (n : ℝ) ((2 : ℝ) / 3)) ∧
      (∀ i, 2 * (A i).card = p i - 1) ∧
      ((n : ℝ) / 3 <
        (((Finset.Icc 1 n).filter
          (fun x => ∀ i, (x : ZMod (p i)) ∉ A i)).card : ℝ)) := by
  refine ⟨D.n, D.p, D.A, D.p_prime, D.p_strictMono, ?_,
    D.A_card_exact_half, ?_⟩
  · intro i
    exact cube_lt_square_to_rpow_two_thirds_kernel
      (D.hpow (D.p i) (D.p_mem i))
  · have hNat : D.n < 3 * D.remaining.card := D.remaining_large
    have hReal :
        (D.n : ℝ) < 3 * (D.remaining.card : ℝ) := by
      exact_mod_cast hNat
    simpa [ClusterData.remaining] using
      (show (D.n : ℝ) / 3 < D.remaining.card by
        nlinarith)

end JSP001007
