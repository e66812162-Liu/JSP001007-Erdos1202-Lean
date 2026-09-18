# Verification record

## Frozen proof snapshot

- Proof repository: `e66812162-Liu/JSP001007-Erdos1202-Lean`
- Verified branch: `verified-v11`
- Verified commit: `04d983cf27a29cb403a192a73fedc961d84b9e25`
- Top theorem: `JSP001007.erdos1202_negative_source_faithful_v11`

## Stable-kernel verification

The full proof chain was compiled successfully with:

```text
Lean 4.34.0
commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b
```

Successful stable verification workflow:

```text
GitHub Actions run 35302485999
JSP-001007 V11 Stable Lean 4.34 Verification
```

The compiler output included:

```text
JSP001007.erdos1202_negative_source_faithful_v11 :
  ¬ Erdos1202SourceStatementV11

'JSP001007.erdos1202_negative_source_faithful_v11'
depends on axioms: [propext, Classical.choice, Quot.sound]

ALL V11 CANDIDATE MODULES COMPILED
```

## Independent audit

Independent audit workflow:

```text
GitHub Actions run 35303092340
JSP-001007 V11 Stable 4.34 Independent Audit
```

This audit passed all of the following:

1. frozen dependency resolution;
2. stable Lean 4.34.0 dependency build;
3. full V11 compilation;
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
jsp001007-v11-stable434-independent-audit
artifact ID: 10531041274
SHA256: 9e9b4c4883f16582cced05c883a3a995b63797dda304132e546bf584cbc25bf7
```

## Frozen dependency revisions for the independent audit

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

No project-specific axiom or proof-bypass placeholder is used in the JSP proof source.

## Reproducibility

The repository contains GitHub Actions workflows for:

- original PrimeGapsLib-environment compilation;
- stable Lean 4.34.0 verification;
- independent stable Lean 4.34.0 kernel audit.

The exact proof source intended for external review is the frozen `verified-v11` commit identified above.
