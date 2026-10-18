# JSP-001007 / Erdős #1202 — V14 Independent Replay and Source-Statement Audit

**Audit date (UTC): 2026-10-18**  
**Subject:** frozen proof commit **A** `2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7` (`verified-v14`).  
**Top theorem:** `JSP001007.erdos1202_negative_public_statement_v14 : ¬ Erdos1202SourceStatementV14`.  
**Official submission:** [TheJustinSunPrize/awards PR #1026](https://github.com/TheJustinSunPrize/awards/pull/1026).

> **Evidence/proof version separation:** This report is a *later evidence-only document*. The commit that adds this report (commit **B**) is **not** the selected proof commit and does not claim Lean verification of B. All verification findings below refer to the unchanged source at proof commit A. The new audit workflow resides on a separate branch, not on frozen `verified-v14`.

## 1. Result summary

- **Mechanical verification: PASS.** A fresh GitHub-hosted Linux runner rebuilt the exact frozen V14 source and completed a kernel check on 2026-10-18. A second, distinct run fetched the **historical** PrimeNumberTheoremAnd archive, **enforced its recorded SHA-256** and the pinned Mathlib revision, then compiled V14, screened bypass tokens and completed `leanchecker`. Both workflows concluded `success`.
- **Source-statement correspondence: no fatal discrepancy detected** under the source site's public quantifier reading. An adversarial comparison was made against Erdős's original printed formulation (1980, p. 107), the Erdős Problems #1202 site, and Ben Green's fixed Problem 44. This judgment is a source-based review, **not** Lean kernel certification or independent acceptance by JSP maintainers.
- **Open limitations:** this exact top-level theorem negates the displayed uniform conjecture, but does not state the stronger `∀ N₀, ∃ n ≥ N₀` arbitrarily-large-n endpoint or the quantitative asymptotic `(1/2-c)n` commentary. It also does not claim independent formalizer priority over earlier public submissions.
- **Award status:** PR #1026 remains under organizer review. A successful author-operated replay does **not** entail official merge, qualification, earliest priority or prize acceptance.

## 2. Immutable proof inputs

| Component | Exact version |
|---|---|
| Proof repository | `e66812162-Liu/JSP001007-Erdos1202-Lean` |
| Frozen proof commit A | `2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7` |
| Top-level file | `candidate/JSP001007_Master_SourceFaithful_V14.lean` |
| Formal statement / proof | `candidate/JSP001007_WP4Q_SourceFaithful_FinalWrapper_V14.lean` |
| Lean toolchain | `leanprover/lean4:v4.34.0` |
| PrimeGapsLib | `1faa7b14e82ddebc2772dfb9153922f01b106477` |
| Historical PrimeNumberTheoremAnd source | `09617eb72103690ef22b027548c60a6126e2ef6d` |
| Historical PNT GitHub tarball SHA-256 | `9ed07e290dfdaec7d0ae09e71e31530880421d2f54b9fd44c20585bba17227c8` |
| Mathlib | `5ed2965256430c3649e86755f9576b54eca72435` |

The historical robust workflow from 2026-09-24 printed the archive digest without a `sha256sum --check` gate. The supplemental 2026-10-18 workflow now **fails on digest mismatch** rather than merely recording the digest. This is a reproducibility improvement, not a modification to the formal theorem.

## 3. Newly executed verification — actual logged evidence

### 3.1 Fresh compatible-upstream crosscheck

- **Run:** [35955253998, attempt 2](https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean/actions/runs/35955253998/attempts/2).
- **New job:** `117556649110`.
- **Executed:** 2026-10-18 01:41–01:45 UTC; result **success**.
- Frozen A was checked out explicitly. Lean 4.34.0, dependency resolution and closure build completed; eight V14 source-chain files compiled and `lake env leanchecker JSP001007_Master_SourceFaithful_V14` passed.
- This crosscheck uses the *reachable compatible* PNT revision `385152bd282e0de0a22dc3ea255c222e4304b608`, not the historical archive. It is therefore **complementary compatibility evidence** rather than historical byte-for-byte dependency reproduction.

The new job log included:

```text
JSP001007.erdos1202_negative_public_statement_v14 : ¬Erdos1202SourceStatementV14
'JSP001007.erdos1202_negative_public_statement_v14' depends on axioms: [propext, Classical.choice, Quot.sound]
ALL V14 CANDIDATE MODULES COMPILED
Run lake env leanchecker JSP001007_Master_SourceFaithful_V14
```

### 3.2 Historical-PNT checksum-enforced replay

- **Run:** [39087808882](https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean/actions/runs/39087808882).
- **Job:** `117557952067`.
- **Executed:** 2026-10-18 01:48–01:52 UTC; result **success**.
- **Supplemental audit branch:** `audit-v14-historical-replay-20261018`.
- **New workflow:** [`.github/workflows/replay-v14-historical-digest.yml`](https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean/blob/c45d886397a51a54e1cce5309939a5c0dc97125e/.github/workflows/replay-v14-historical-digest.yml); workflow-only commit `c45d886397a51a54e1cce5309939a5c0dc97125e`.
- Explicitly checked out proof commit A, confirmed `git rev-parse HEAD`, checked PrimeGapsLib's SHA, checked the historical PNT archive via **`sha256sum --check`**, and validated the actual Mathlib checkout equals its pinned SHA.
- Built the complete dependency closure and V14 chain; bypass-token scan and Lean kernel checker both succeeded.
- Uploaded verification artifact `jsp001007-v14-sha256-enforced-replay` (artifact **12121423029**; generated ZIP SHA-256 `f2211922cf8c1c6e46dc7ef2f756facab4d1fa5c0a54bea6b0cb29c7aef57426`). GitHub's artifact retention is time-limited; the immutable workflow commit, permanent source references and this report preserve the audit recipe and key observed outputs.

Selected new job-log excerpts:

```text
pnta.tar.gz: OK
JSP001007.erdos1202_negative_public_statement_v14 : ¬Erdos1202SourceStatementV14
'JSP001007.erdos1202_negative_public_statement_v14' depends on axioms: [propext, Classical.choice, Quot.sound]
ALL V14 CANDIDATE MODULES COMPILED
No forbidden bypass tokens in V14 source chain
Run lake env leanchecker JSP001007_Master_SourceFaithful_V14
```

The reported axiom list comprises the standard `propext`, `Classical.choice` and `Quot.sound` only. A successful kernel check verifies the **formal statement declared in Lean**, not automatically the intended informal original question.

## 4. Original-statement comparison

Primary sources:
1. [P. Erdős, *A survey of problems in combinatorial number theory*, 1980, Section 6, Problem 3, printed p. 107](https://www.renyi.hu/~p_erdos/1980-03.pdf#page=19).
2. [Erdős Problems #1202, public statement and discussion](https://www.erdosproblems.com/1202).
3. [Ben Green, *100 Open Problems*, Problem 44, printed p. 22](https://people.maths.ox.ac.uk/greenbj/papers/open-problems.pdf#page=22).

| Feature | V14 correspondence | Judgment |
|---|---|---|
| `ε, η > 0` | Quantifies over both, chooses `ε=1/3, η=1` for refutation | **Match:** the printed `η` has no other operative occurrence; no new restriction is invented |
| Prime family | `p : Fin k → ℕ`, `Nat.Prime` and `StrictMono p` | **Match** for ordered distinct primes |
| Upper bound | `∀ i, (p i : ℝ) < Real.rpow (n : ℝ) (1-ε)` | **Match**; using `p³ < n²` at `ε=1/3` |
| Deleted classes | `2 * (A i).card = p i - 1` | **Literal exact-half match** for the admissible odd primes; avoids truncated arithmetic ambiguity at `p=2` |
| Survivors | Filter over `Finset.Icc 1 n` and all indices | **Match** for integers `1 ≤ m ≤ n` |
| Terminal bound | V14 says survivors `≤ εn` while the 1980 print uses a strict `< εn` and the modern site says “at most” | **Safe strengthening:** disproving the weak `≤` proposition also disproves the strict `<` reading |
| `k = 0` | V14 allows this option for the positive proposition, yet still proves its negation | **Conservative strengthening**, not a hidden positive-`k` assumption |
| `n > 0` | Domain explicit and constructed witness positive | **Conventional nonzero-size domain**, prevents meaningless edge-case objection |

**Math-specific spot check of the construction.** Let `p = B+d` with `0 < d ≤ H`; choose `0 ≤ q < Q`, `L=(Q-1)H`, `L ≤ r < B/2`, and `x=qB+r`. Then `q d ≤ L ≤ r`, hence `x mod p = r-q d < B/2`; the deleted residues begin at `B/2`, so every rectangle element survives every selected modulus. The rectangle contributes `Q(B/2-L)` distinct survivors out of `n=QB`; the verified inequality `6L<B` gives more than `n/3` survivors. The verified `p³<n²` gives the prime-size constraint. The prime-density input supplies a suitable cluster for each `k`. This is a human-readable cross-check of the Lean proof chain, not an additional independently kernel-checked theorem.

**Boundaries:** The selected top theorem is a counterexample to the **displayed universal** Erdős #1202 statement. It does **not** directly formalize the stronger `(1/2-c)n` asymptotic claim in the problem-site commentary. It also does **not** have an explicit top-level `∀ N₀, ∃ n ≥ N₀` endpoint. If a maintainer requires an *eventually uniform* rather than displayed universal interpretation, request a separately scoped formal bridge before asserting that stronger result. Green's fixed `1000`-prime, `N^{9/10}`, `N/10` formulation is related but not literally identical in quantifier structure; the current theorem's explicit refutation is about Erdős #1202.

## 5. Trust boundaries and next external-review steps

1. **Lean proof/kernel outcome: verified in author-controlled GitHub Actions.** The supplemental runs reproduce real execution with frozen proof bytes. They are not independent third-party or maintainer approval.
2. **Source correspondence: reviewed, not organizer-certified.** Maintainers must resolve any contextual ambiguity in the 1980 wording and any intended eventual-`n` stronger endpoint.
3. **Priority: not established.** Earlier publicly documented JSP-001007 submissions, including [#107](https://github.com/TheJustinSunPrize/awards/pull/107) continued as [#2284](https://github.com/TheJustinSunPrize/awards/pull/2284), require separate verified proof-version/public-history comparisons. New checks in 2026-10 do not backdate this formalization.
4. **Official award: unresolved.** [PR #1026](https://github.com/TheJustinSunPrize/awards/pull/1026) still requires maintainers' independent statement, verification and attribution decisions. JSP-001007 is not part of the new MathDB pilot register and remains on the legacy contribution path.
5. **Historical reproducibility improved:** the earlier PNT archive digest was *recorded*; the new workflow enforces it. For an independent follow-up, fork or reproduce the committed workflow recipe and retain full logs plus source/dependency SHA confirmations.

### Verdict

**No fatal V14 proof or source-fidelity defect identified from the inspected evidence.** The exact frozen V14 theorem successfully compiled and passed `leanchecker` again on 2026-10-18, including one replay that enforces the historical archive SHA-256. **Do not rewrite the frozen proof or present these results as an official JSP approval, earliest-priority determination or guarantee of award.**
