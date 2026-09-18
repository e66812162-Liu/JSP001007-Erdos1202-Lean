import Mathlib
import PrimeGapsTheory.NumberTheory.DyadicPNT

namespace JSP001007

open Real

/-
WP4-N / PNT StaticAuditV5.

Changes retained from V3:
* uses the current source signature of `PNT.primeCountingIoc_self_two_mul`;
* no `field_simp` in the half-main-term estimate;
* Nat/Real threshold casting is localized;
* the final polynomial comparison is explicit.

V4 red-team correction:
* fixes the proof of `t ≤ t^4`.

V5 hardening:
* proves `2 ≤ M` explicitly from `0 < t^4`.

IMPORTANT: first real Lean build is performed by repository CI.
-/

private lemma log_arch51_upper_v3
    {t : ℕ} (ht : 395 ≤ t) :
    Real.log (400 * (t : ℝ)^4) ≤ 5 * t := by
  have htpos : (0 : ℝ) < t := by positivity
  have hlog400 : Real.log (400 : ℝ) ≤ 399 := by
    have h :=
      Real.log_le_sub_one_of_pos (show (0 : ℝ) < 400 by norm_num)
    norm_num at h
    exact h
  have hlogt : Real.log (t : ℝ) ≤ (t : ℝ) - 1 := by
    exact Real.log_le_sub_one_of_pos htpos
  have htR : (395 : ℝ) ≤ (t : ℝ) := by
    exact_mod_cast ht
  calc
    Real.log (400 * (t : ℝ)^4)
        = Real.log (400 : ℝ) + Real.log ((t : ℝ)^4) := by
            rw [Real.log_mul (by norm_num : (400 : ℝ) ≠ 0)
              (pow_ne_zero 4 (ne_of_gt htpos))]
    _ = Real.log (400 : ℝ) + 4 * Real.log (t : ℝ) := by
          rw [Real.log_pow]
          norm_num
    _ ≤ 399 + 4 * ((t : ℝ) - 1) := by
          exact add_le_add hlog400
            (mul_le_mul_of_nonneg_left hlogt (by norm_num))
    _ ≤ 5 * (t : ℝ) := by
          nlinarith [htR]

private lemma pnt_half_main_term_v3
    {C : ℝ} {M count : ℕ}
    (hM : 2 ≤ M)
    (hlogC : 2 * |C| ≤ Real.log M)
    (hpnt :
      |(count : ℝ) - M / Real.log M|
        ≤ C * M / Real.log M ^ 2) :
    (M : ℝ) / (2 * Real.log M) ≤ count := by
  have hlogpos : 0 < Real.log (M : ℝ) :=
    Real.log_pos (by exact_mod_cast hM)
  have hMnonneg : (0 : ℝ) ≤ M := by positivity
  have hlogsqpos : 0 < Real.log (M : ℝ)^2 := sq_pos_of_pos hlogpos
  have htwologpos : 0 < 2 * Real.log (M : ℝ) := by positivity

  have hscale :
      0 ≤ (M : ℝ) / Real.log M ^ 2 := by
    exact div_nonneg hMnonneg hlogsqpos.le

  have herr :
      |(count : ℝ) - M / Real.log M|
        ≤ |C| * M / Real.log M ^ 2 := by
    calc
      |(count : ℝ) - M / Real.log M|
          ≤ C * M / Real.log M ^ 2 := hpnt
      _ = C * ((M : ℝ) / Real.log M ^ 2) := by ring
      _ ≤ |C| * ((M : ℝ) / Real.log M ^ 2) :=
            mul_le_mul_of_nonneg_right (le_abs_self C) hscale
      _ = |C| * M / Real.log M ^ 2 := by ring

  have hlow :
      M / Real.log M
        - |C| * M / Real.log M ^ 2
      ≤ (count : ℝ) := by
    have habsLow :
        -|(count : ℝ) - M / Real.log M|
          ≤ (count : ℝ) - M / Real.log M :=
      neg_abs_le _
    have hneg :
        -(|C| * M / Real.log M ^ 2)
          ≤ -|(count : ℝ) - M / Real.log M| := by
      linarith
    linarith

  have herrhalf :
      |C| * M / Real.log M ^ 2
        ≤ M / (2 * Real.log M) := by
    apply (div_le_div_iff₀ hlogsqpos htwologpos).2
    have hfactor :
        0 ≤ (M : ℝ) * Real.log M :=
      mul_nonneg hMnonneg hlogpos.le
    have hmul :=
      mul_le_mul_of_nonneg_right hlogC hfactor
    simpa [pow_two, mul_assoc, mul_left_comm, mul_comm] using hmul

  have hlogne : Real.log (M : ℝ) ≠ 0 := ne_of_gt hlogpos
  have hmain_double :
      (M : ℝ) / Real.log M =
        2 * ((M : ℝ) / (2 * Real.log M)) := by
    field_simp [hlogne]
    <;> ring
  rw [hmain_double] at hlow
  linarith

theorem dyadic_many_primes_arch51_v3 (k : ℕ) :
    ∃ t : ℕ,
      395 ≤ t ∧
      10 * k ≤ t ∧
      Even t ∧
      (400 * t^2) * k
        ≤ Nat.primeCountingIoc (400 * t^4) (800 * t^4) := by
  obtain ⟨C, N₀, hPNT⟩ := PNT.primeCountingIoc_self_two_mul

  obtain ⟨Texp, hTexp⟩ :
      ∃ Texp : ℕ, Real.exp (2 * |C|) < Texp := by
    exact exists_nat_gt (Real.exp (2 * |C|))

  let R : ℕ := max 395 (max (10 * k) (max N₀ Texp))
  let t : ℕ := 2 * R
  let M : ℕ := 400 * t^4

  have hR395 : 395 ≤ R := by
    dsimp [R]
    omega
  have hRk : 10 * k ≤ R := by
    dsimp [R]
    omega
  have hRN₀ : N₀ ≤ R := by
    dsimp [R]
    omega
  have hRTexp : Texp ≤ R := by
    dsimp [R]
    omega

  have ht395 : 395 ≤ t := by
    dsimp [t]
    omega
  have htk : 10 * k ≤ t := by
    dsimp [t]
    omega
  have hteven : Even t := by
    refine ⟨R, ?_⟩
    dsimp [t]
    omega

  have htpos : 0 < t := by omega
  have hM2 : 2 ≤ M := by
    dsimp [M]
    have ht4pos : 0 < t^4 := pow_pos htpos 4
    omega

  have htM : t ≤ M := by
    dsimp [M]
    have hpow : t ≤ t^4 := by
      have h :=
        Nat.le_mul_of_pos_right t (pow_pos htpos 3)
      simpa [pow_succ, mul_assoc, mul_left_comm, mul_comm] using h
    have hscale : t^4 ≤ 400 * t^4 :=
      Nat.le_mul_of_pos_left (t^4) (by norm_num)
    exact hpow.trans hscale

  have hN₀M : N₀ ≤ M := by
    have hRt : R ≤ t := by
      dsimp [t]
      omega
    exact hRN₀.trans (hRt.trans htM)

  have hExpM :
      Real.exp (2 * |C|) < (M : ℝ) := by
    have hTt : Texp ≤ t := hRTexp.trans (by
      dsimp [t]
      omega)
    have hTM_nat : Texp ≤ M := hTt.trans htM
    have hTM_real : (Texp : ℝ) ≤ (M : ℝ) := by
      exact_mod_cast hTM_nat
    exact hTexp.trans_le hTM_real

  have hlogC : 2 * |C| ≤ Real.log (M : ℝ) := by
    have hloglt :
        Real.log (Real.exp (2 * |C|)) < Real.log (M : ℝ) := by
      exact Real.log_lt_log (Real.exp_pos _) hExpM
    simpa using hloglt.le

  have hpnt :
      |(Nat.primeCountingIoc M (2 * M) : ℝ) - M / Real.log M|
        ≤ C * M / Real.log M ^ 2 :=
    hPNT M hN₀M

  have hhalf :
      (M : ℝ) / (2 * Real.log M)
        ≤ Nat.primeCountingIoc M (2 * M) :=
    pnt_half_main_term_v3 hM2 hlogC hpnt

  have hlogUpper :
      Real.log (M : ℝ) ≤ 5 * t := by
    dsimp [M]
    simpa [Nat.cast_mul, Nat.cast_pow] using
      (log_arch51_upper_v3 ht395)

  have hlogpos : 0 < Real.log (M : ℝ) :=
    Real.log_pos (by exact_mod_cast hM2)

  have hmainLower :
      (40 * t^3 : ℝ) ≤ (M : ℝ) / (2 * Real.log M) := by
    apply (le_div_iff₀ (by positivity : 0 < 2 * Real.log (M : ℝ))).2
    have hden :
        2 * Real.log (M : ℝ) ≤ 10 * t := by
      nlinarith
    have h40nonneg : (0 : ℝ) ≤ 40 * t^3 := by positivity
    calc
      (40 * t^3 : ℝ) * (2 * Real.log M)
          ≤ (40 * t^3) * (10 * t) :=
            mul_le_mul_of_nonneg_left hden h40nonneg
      _ = 400 * (t : ℝ)^4 := by ring
      _ = (M : ℝ) := by
            dsimp [M]
            norm_num

  have hcountReal :
      (40 * t^3 : ℝ)
        ≤ Nat.primeCountingIoc M (2 * M) :=
    hmainLower.trans hhalf

  have hcountNat :
      40 * t^3
        ≤ Nat.primeCountingIoc M (2 * M) := by
    exact_mod_cast hcountReal

  have hkpoly :
      (400 * t^2) * k ≤ 40 * t^3 := by
    calc
      (400 * t^2) * k = (40 * t^2) * (10 * k) := by ring
      _ ≤ (40 * t^2) * t := Nat.mul_le_mul_left _ htk
      _ = 40 * t^3 := by ring

  refine ⟨t, ht395, htk, hteven, ?_⟩
  have h := hkpoly.trans hcountNat
  dsimp [M] at h
  have htwo :
      2 * (400 * t^4) = 800 * t^4 := by
    ring
  rw [htwo] at h
  exact h

end JSP001007
