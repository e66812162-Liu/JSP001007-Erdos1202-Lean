# Verification record

## Frozen proof snapshot

- Proof repository: `e66812162-Liu/JSP001007-Erdos1202-Lean`
- Verified branch: `verified-v12`
- Verified commit: `2e53fb5325604e34311e4600aa9e845fecfda09d`
- Top theorem: `JSP001007.erdos1202_negative_public_statement_v12`
- Top file: `candidate/JSP001007_Master_SourceFaithful_V12.lean`

## Stable-kernel verification

The full V12 proof chain compiled successfully with Lean 4.34.0.

Successful stable verification workflow:

```text
GitHub Actions run 35307229093
JSP-001007 V12 Stable Lean 4.34 Verification
```

The compiler output included:

```text
JSP001007.erdos1202_negative_public_statement_v12 :
  ¬ Erdos1202SourceStatementV12

'JSP001007.erdos1202_negative_public_statement_v12'
depends on axioms: [propext, Classical.choice, Quot.sound]

ALL V12 CANDIDATE MODULES COMPILED
```

Stable verification artifact:

```text
jsp001007-v12-stable434-logs
artifact ID: 10531682924
SHA256: c7c3e1003b98fe00833c1ee939bfa359ff08d47e0802ea680b1f4cda100950b6
```

## Independent audit

Independent audit workflow:

```text
GitHub Actions run 35307229141
JSP-001007 V12 Stable 4.34 Independent Audit
```

This audit passed all of the following:

1. frozen dependency resolution;
2. stable Lean 4.34.0 dependency build;
3. full V12 compilation;
4. `#print axioms`;
5. forbidden-token scan;
6. independent `leanchecker`.

The source scan reported:

```text
No forbidden proof-bypass tokens found in JSP source.
```

The independent `leanchecker` step completed successfully.

Audit artifact:

```text
jsp001007-v12-stable434-independent-audit
artifact ID: 10532421526
SHA256: 1a75e66e64dd294c1134ea0bc83b263dee95ec5f03fdbedb92a5eb7d81791d40
```

## Frozen dependency revisions

```text
PrimeGapsLib:
1faa7b14e82ddebc2772dfb9153922f01b106477

Mathlib:
5ed2965256430c3649e86755f9576b54eca72435

PrimeNumberTheoremAnd:
09617eb72103690ef22b027548c60a6126e2ef6d
```

## Axiom policy

The final theorem reports only:

```text
propext
Classical.choice
Quot.sound
```

No project-specific axiom or proof-bypass placeholder is used in the JSP proof
source.

## Statement-fidelity update from V11

V11 used a strict terminal inequality `< ε*n`.  V12 replaces this with
`≤ ε*n` to match the current public wording "at most ε n".  The underlying
counterexample construction already proves a strict lower bound above
`n/3`, so the mathematical core is unchanged.

See [STATEMENT_COMPARISON_V12.md](STATEMENT_COMPARISON_V12.md).

## Reproducibility

The exact proof source intended for external review is the public branch
`verified-v12` at the full commit SHA given above.  The repository also keeps
the earlier V11 history for auditability.
