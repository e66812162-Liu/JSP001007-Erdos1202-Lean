# Verification record

## Canonical frozen proof snapshot

- Proof repository: `e66812162-Liu/JSP001007-Erdos1202-Lean`
- Verified branch: `verified-v14`
- Verified commit: `2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7`
- Top theorem: `JSP001007.erdos1202_negative_public_statement_v14`
- Top file: `candidate/JSP001007_Master_SourceFaithful_V14.lean`
- Lean: **4.34.0**

## V14 candidate verification

Successful workflow:

```text
GitHub Actions run 35954341357
JSP-001007 V14 Candidate Verification
```

The run successfully:

1. materialized the frozen analytic dependency snapshot;
2. resolved the Lean 4.34 dependency graph;
3. built the dependency closure;
4. recompiled the V12 base chain;
5. compiled the V14 wrapper and master;
6. replayed the V14 module with `leanchecker`.

The compiler output includes:

```text
JSP001007.erdos1202_negative_public_statement_v14 :
  ¬ Erdos1202SourceStatementV14

'JSP001007.erdos1202_negative_public_statement_v14'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Robust independent audit

Successful workflow:

```text
GitHub Actions run 35954341376
JSP-001007 V14 Robust Independent Audit
```

The audit passed:

- full V14 compilation;
- `#print axioms`;
- forbidden-token scan;
- independent `leanchecker`;
- frozen dependency metadata recording;
- evidence artifact upload.

The source scan reported:

```text
No forbidden proof-bypass tokens found.
```

Audit artifact:

```text
name: jsp001007-v14-robust-audit
artifact ID: 10789856945
SHA256: 8a736a30c863cbeba3cff674d7add71c2b22b3d61d5dc7f6ddac05fc99634695
```

## Closed adversarial death audit

Canonical expanded workflow:

```text
GitHub Actions run 35955551095
JSP-001007 V12 Closed Death Audit
```

An earlier audit run 35953961348 had already passed the first three audit
modules.  Run 35955551095 is the stronger canonical record: it recompiled the
frozen V12 proof, compiled and kernel-checked all adversarial audit modules,
compiled the V14 wrapper, and kernel-checked the source-convention bridge.

It formally verified that the same counterexample survives the following
statement/domain perturbations:

- no explicit positivity premise on `k`;
- positive-`n` source domain;
- historical strict terminal inequality `< ε*n`;
- floor-half residue convention on the constructed odd primes.

It also checked the strictly-increasing last-prime/all-primes bound bridge,
the exact-half exclusion of `p = 2`, and the proposition-strength bridges

```lean
v12_implies_v14_audit
erdos1202_negative_positive_k_positive_n_bridge_audit
```

so the promotion to V14 is formally connected to both the V12 reading and a
reading that explicitly requires positive `k` and positive `n`.

The audited bridge and positive-`n` theorems report only:

```text
[propext, Classical.choice, Quot.sound]
```

and their modules passed `leanchecker`.

See [CLOSED_DEATH_AUDIT_V14.md](CLOSED_DEATH_AUDIT_V14.md).

## Frozen dependency inputs

```text
PrimeGapsLib:
1faa7b14e82ddebc2772dfb9153922f01b106477

Mathlib:
5ed2965256430c3649e86755f9576b54eca72435

PrimeNumberTheoremAnd historical source snapshot:
09617eb72103690ef22b027548c60a6126e2ef6d
```

The robust audit materializes the historical PrimeNumberTheoremAnd source via a
GitHub source archive and records its archive hash:

```text
SHA256(pnta.tar.gz):
9ed07e290dfdaec7d0ae09e71e31530880421d2f54b9fd44c20585bba17227c8
```

This archive-based route was added after upstream repository history changed
such that a fresh direct Git checkout of the historical commit was no longer a
reliable reproduction path.  The exact historical source archive remains
retrievable and hash-checked, so V14's audit does not rely on a moving upstream
branch.

## Current-upstream compatibility cross-check

The exact frozen V14 proof was also rebuilt against a currently reachable
Lean-4.34-compatible PrimeNumberTheoremAnd revision:

```text
GitHub Actions run 35955253998
JSP-001007 V14 Current-Upstream Crosscheck

PrimeNumberTheoremAnd:
385152bd282e0de0a22dc3ea255c222e4304b608
```

That cross-check successfully resolved the dependency graph, built the analytic
dependency closure, compiled the exact `verified-v14` proof, reported only
`[propext, Classical.choice, Quot.sound]`, and completed `leanchecker`.

This is supplementary compatibility evidence.  The canonical robust audit
still records the historical source snapshot used by the original proof
development.

## Axiom policy

The canonical theorem reports only:

```text
propext
Classical.choice
Quot.sound
```

No project-specific axiom, `sorry`, `admit`, `unsafe`,
`native_decide`, or `skipKernelTC` occurs in the canonical V14 proof chain.

## Version history

- **V11**: historical strict terminal wrapper.
- **V12**: aligned terminal condition to current public "at most ε n" wording.
- **V13**: death-audit candidate removing an extra `0 < k` convention;
  independently compiled and kernel-checked.
- **V14**: canonical hardened wrapper, additionally making the positive
  `n` source domain explicit.

The mathematical prime-cluster and survivor construction is unchanged across
V12–V14.  The later versions harden only the statement interface and
reproducibility package.
