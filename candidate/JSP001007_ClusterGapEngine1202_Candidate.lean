import Mathlib

namespace JSP001007

/-
Standalone Cluster–Gap engine for Erdős #1202.

No explicit Green-44 witness and no PNT dependency appears here.
This isolates the finite/combinatorial part of the proof.

IMPORTANT: code-level candidate; not Lean-kernel compiled in this environment.
-/

def deletedBlock1202 (B p : ℕ) : Finset (ZMod p) :=
  (Finset.Ico (B / 2) (B / 2 + (p - 1) / 2)).image
    (fun a : ℕ => (a : ZMod p))

lemma deletedBlock1202_upper
    {B p : ℕ} (hBp : B < p) :
    B / 2 + (p - 1) / 2 ≤ p := by
  omega

lemma deletedBlock1202_card
    {B p : ℕ} (hBp : B < p) :
    (deletedBlock1202 B p).card = (p - 1) / 2 := by
  classical
  have hupper := deletedBlock1202_upper hBp
  have hinj :
      Set.InjOn (fun a : ℕ => (a : ZMod p))
        ↑(Finset.Ico (B / 2) (B / 2 + (p - 1) / 2)) := by
    intro a ha b hb hab
    have ha' : a ∈ Finset.Ico (B / 2) (B / 2 + (p - 1) / 2) := by
      simpa using ha
    have hb' : b ∈ Finset.Ico (B / 2) (B / 2 + (p - 1) / 2) := by
      simpa using hb
    have halt : a < p :=
      lt_of_lt_of_le (Finset.mem_Ico.mp ha').2 hupper
    have hblt : b < p :=
      lt_of_lt_of_le (Finset.mem_Ico.mp hb').2 hupper
    have hv := congrArg ZMod.val hab
    rw [ZMod.val_natCast_of_lt halt, ZMod.val_natCast_of_lt hblt] at hv
    exact hv
  unfold deletedBlock1202
  rw [Finset.card_image_of_injOn hinj]
  simp

lemma natCast_not_mem_deletedBlock1202
    {B p x : ℕ}
    (hBp : B < p)
    (hmod : x % p < B / 2) :
    (x : ZMod p) ∉ deletedBlock1202 B p := by
  classical
  intro hx
  have hx' :
      (x : ZMod p) ∈
        (Finset.Ico (B / 2) (B / 2 + (p - 1) / 2)).image
          (fun a : ℕ => (a : ZMod p)) := by
    simpa [deletedBlock1202] using hx
  rcases Finset.mem_image.mp hx' with ⟨a, ha, hax⟩
  have hupper := deletedBlock1202_upper hBp
  have haI := Finset.mem_Ico.mp ha
  have halt : a < p := lt_of_lt_of_le haI.2 hupper
  have hv := congrArg ZMod.val hax
  rw [ZMod.val_natCast_of_lt halt, ZMod.val_natCast p x] at hv
  omega

lemma clusterGap_mod1202
    {B H Q p q r : ℕ}
    (hBp : B < p)
    (hpH : p ≤ B + H)
    (hq : q < Q)
    (hrlo : (Q - 1) * H ≤ r)
    (hrhi : r < B / 2) :
    (q * B + r) % p = r - q * (p - B) := by
  have hBple : B ≤ p := Nat.le_of_lt hBp
  have hpdecomp : B + (p - B) = p := Nat.add_sub_of_le hBple
  have hdle : p - B ≤ H := by omega
  have hqle : q ≤ Q - 1 := by omega
  have hqdle : q * (p - B) ≤ (Q - 1) * H :=
    Nat.mul_le_mul hqle hdle
  have hqdr : q * (p - B) ≤ r := le_trans hqdle hrlo
  have hrem_lt : r - q * (p - B) < p := by
    have hsub : r - q * (p - B) ≤ r := Nat.sub_le _ _
    omega
  have hdecomp :
      q * B + r = q * p + (r - q * (p - B)) := by
    calc
      q * B + r
          = q * B + (q * (p - B) + (r - q * (p - B))) := by
              rw [Nat.add_sub_of_le hqdr]
      _ = q * (B + (p - B)) + (r - q * (p - B)) := by ring
      _ = q * p + (r - q * (p - B)) := by rw [hpdecomp]
  rw [hdecomp]
  exact Nat.mul_add_mod_of_lt hrem_lt

lemma clusterGap_avoids_deletedBlock1202
    {B H Q p q r : ℕ}
    (hBp : B < p)
    (hpH : p ≤ B + H)
    (hq : q < Q)
    (hrlo : (Q - 1) * H ≤ r)
    (hrhi : r < B / 2) :
    ((q * B + r : ℕ) : ZMod p) ∉ deletedBlock1202 B p := by
  apply natCast_not_mem_deletedBlock1202 hBp
  rw [clusterGap_mod1202 hBp hpH hq hrlo hrhi]
  exact lt_of_le_of_lt (Nat.sub_le _ _) hrhi

def pairBox1202 (B H Q : ℕ) : Finset (ℕ × ℕ) :=
  Finset.range Q ×ˢ Finset.Ico ((Q - 1) * H) (B / 2)

def encode1202 (B : ℕ) (qr : ℕ × ℕ) : ℕ :=
  qr.1 * B + qr.2

def rectangle1202 (B H Q : ℕ) : Finset ℕ :=
  (pairBox1202 B H Q).image (encode1202 B)

lemma encode1202_injOn
    {B H Q : ℕ} (hB : 0 < B) :
    Set.InjOn (encode1202 B) ↑(pairBox1202 B H Q) := by
  intro z hz z' hz' heq
  rcases z with ⟨q, r⟩
  rcases z' with ⟨q', r'⟩
  change q * B + r = q' * B + r' at heq
  simp [pairBox1202] at hz hz'
  rcases hz with ⟨hq, hrlo, hrhi⟩
  rcases hz' with ⟨hq', hrlo', hrhi'⟩
  have hrB : r < B := by omega
  have hrB' : r' < B := by omega
  have hmod := congrArg (fun n : ℕ => n % B) heq
  rw [Nat.mul_add_mod_of_lt hrB, Nat.mul_add_mod_of_lt hrB'] at hmod
  subst r'
  have hmul : q * B = q' * B := Nat.add_right_cancel heq
  have hqEq : q = q' := Nat.mul_right_cancel hB hmul
  subst q'
  rfl

lemma rectangle1202_card
    {B H Q : ℕ} (hB : 0 < B) :
    (rectangle1202 B H Q).card =
      Q * (B / 2 - (Q - 1) * H) := by
  classical
  unfold rectangle1202
  rw [Finset.card_image_of_injOn
    (encode1202_injOn (B := B) (H := H) (Q := Q) hB)]
  simp [pairBox1202]

end JSP001007
