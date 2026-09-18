import Mathlib
import PrimeGapsTheory.NumberTheory.PrimeCountingInterval
import JSP001007_WP4N_DyadicPNTLowerBound_V5
import JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4
import JSP001007_WP4P_ClusterToCounterexample_Kernel_V6

namespace JSP001007

/-
WP4-P modular adapter V4 (PNT V5 + pure kernel V6).

This is deliberately the only PNT-dependent construction layer:

    dyadic PNT
      -> enough primes in (M,2M]
      -> one short dense prime box
      -> ClusterData k

All residue-class, rectangle, survivor and real-rpow arguments are delegated to
the pure-Mathlib kernel.

IMPORTANT: first real Lean build is performed by repository CI.
-/

def primeWindowL (M : ℕ) : Finset ℕ :=
  (Finset.Ioc M (2 * M)).filter Nat.Prime

lemma primeWindowL_card (M : ℕ) :
    (primeWindowL M).card = Nat.primeCountingIoc M (2 * M) := by
  rfl

theorem clusterData_arch51_exists (k : ℕ) :
    ∃ D : ClusterData k, True := by
  obtain ⟨t, ht395, htk, hteven, hcount⟩ :=
    dyadic_many_primes_arch51_v3 k

  let M : ℕ := 400 * t^4
  let s : Finset ℕ := primeWindowL M

  have htpos : 0 < t := by omega

  have hs :
      ∀ p ∈ s, 400 * t^4 < p ∧ p ≤ 800 * t^4 := by
    intro p hp
    have hp' := Finset.mem_filter.mp hp
    have hI := Finset.mem_Ioc.mp hp'.1
    dsimp [s, M] at hI
    constructor
    · exact hI.1
    · calc
        p ≤ 2 * (400 * t^4) := hI.2
        _ = 800 * t^4 := by ring

  have hsCardEq :
      s.card =
        Nat.primeCountingIoc (400 * t^4) (800 * t^4) := by
    have hsCardM :
        s.card = Nat.primeCountingIoc M (2 * M) := by
      dsimp [s]
      exact primeWindowL_card M
    calc
      s.card = Nat.primeCountingIoc M (2 * M) := hsCardM
      _ = Nat.primeCountingIoc (400 * t^4) (800 * t^4) := by
        dsimp [M]
        rw [show 2 * (400 * t^4) = 800 * t^4 by ring]

  have hscard :
      (400 * t^2) * k ≤ s.card := by
    rw [hsCardEq]
    exact hcount

  obtain ⟨B, hBlo, hBhi, hBeven, hclusterCard⟩ :=
    arch51_dense_interval_v4 htpos hteven s hs hscard

  let H : ℕ := t^2
  let Q : ℕ := 60 * t^2
  let P : Finset ℕ :=
    s.filter (fun p => B < p ∧ p ≤ B + H)

  have hkP : k ≤ P.card := by
    simpa [P, H] using hclusterCard

  have hprime : ∀ p ∈ P, p.Prime := by
    intro p hp
    have hpP := Finset.mem_filter.mp hp
    have hps := Finset.mem_filter.mp hpP.1
    exact hps.2

  have hcluster : ∀ p ∈ P, B < p ∧ p ≤ B + H := by
    intro p hp
    exact (Finset.mem_filter.mp hp).2

  have hBpos : 0 < B := by
    have hbase : 0 < 400 * t^4 := by positivity
    omega

  have hHpos : 0 < H := by
    dsimp [H]
    positivity

  have hQpos : 0 < Q := by
    dsimp [Q]
    positivity

  have hQgt1 : 1 < Q := by
    dsimp [Q]
    have ht2pos : 0 < t^2 := by positivity
    omega

  have hLsmall :
      6 * ((Q - 1) * H) < B := by
    have hQm1 : Q - 1 < Q := Nat.sub_lt (by positivity) (by norm_num)
    have hmulH :
        (Q - 1) * H < Q * H :=
      Nat.mul_lt_mul_of_pos_right hQm1 hHpos
    have h6 :
        6 * ((Q - 1) * H) < 6 * (Q * H) :=
      Nat.mul_lt_mul_of_pos_left hmulH (by norm_num)
    have hQH : 6 * (Q * H) = 360 * t^4 := by
      dsimp [Q, H]
      ring
    have h360 : 360 * t^4 < 400 * t^4 := by
      have ht4 : 0 < t^4 := pow_pos htpos 4
      exact Nat.mul_lt_mul_of_pos_right (by norm_num) ht4
    calc
      6 * ((Q - 1) * H)
          < 6 * (Q * H) := h6
      _ = 360 * t^4 := hQH
      _ < 400 * t^4 := h360
      _ ≤ B := hBlo

  have hnLower :
      24000 * t^6 ≤ Q * B := by
    have hmul :=
      Nat.mul_le_mul_left (60 * t^2) hBlo
    have hident :
        (60 * t^2) * (400 * t^4) = 24000 * t^6 := by
      ring
    dsimp [Q]
    rw [hident] at hmul
    exact hmul

  have hpow : ∀ p ∈ P, p^3 < (Q * B)^2 := by
    intro p hp
    have hpclus := hcluster p hp
    have hpUpper : p ≤ 800 * t^4 := by
      dsimp [H] at hpclus
      omega

    have hp3 :
        p^3 ≤ (800 * t^4)^3 :=
      Nat.pow_le_pow_left hpUpper 3
    have hn2 :
        (24000 * t^6)^2 ≤ (Q * B)^2 :=
      Nat.pow_le_pow_left hnLower 2
    have hupper :
        (800 * t^4)^3 = 512000000 * t^12 := by ring
    have hlower :
        (24000 * t^6)^2 = 576000000 * t^12 := by ring
    have ht12 : 0 < t^12 := pow_pos htpos 12
    have hstrict :
        512000000 * t^12 < 576000000 * t^12 :=
      Nat.mul_lt_mul_of_pos_right (by norm_num) ht12

    calc
      p^3 ≤ (800 * t^4)^3 := hp3
      _ = 512000000 * t^12 := hupper
      _ < 576000000 * t^12 := hstrict
      _ = (24000 * t^6)^2 := hlower.symm
      _ ≤ (Q * B)^2 := hn2

  refine ⟨{
    B := B
    H := H
    Q := Q
    P := P
    hkP := hkP
    hprime := hprime
    hcluster := hcluster
    hBpos := hBpos
    hHpos := hHpos
    hQpos := hQpos
    hQgt1 := hQgt1
    hBeven := hBeven
    hLsmall := hLsmall
    hpow := hpow
  }, trivial⟩

end JSP001007
