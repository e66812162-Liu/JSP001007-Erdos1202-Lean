# Attribution

## Mathematical solution

The underlying negative mathematical solution to Erdős Problem #1202 /
JSP-001007 is **not claimed as original work by this repository**.

Mathematical solution credit remains:

```text
Liam Price and GPT-5.4 Pro
```

as recorded by the Justin Sun Prize problem bank at the time this formalization
was prepared.

## Lean formalization

Lean formalization contribution:

```text
GitHub account: e66812162-Liu
Repository: e66812162-Liu/JSP001007-Erdos1202-Lean
```

The repository contains the formalization, proof-engineering history,
statement-fidelity audit, stable-kernel verification, and reproducibility
evidence.

The contribution claim is **Lean formalization only**, not mathematical solver
credit.

## Canonical scope

The current external-review theorem is:

```lean
JSP001007.erdos1202_negative_public_statement_v14 :
  ¬ Erdos1202SourceStatementV14
```

Frozen review source:

```text
branch: verified-v14
commit: 2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7
```

V14 is a statement-interface hardening of the same counterexample formalized
in V12.  See `STATEMENT_COMPARISON_V14.md` and
`CLOSED_DEATH_AUDIT_V14.md`.

## Priority / overlap disclaimer

Public searches of the official awards repository show multiple JSP-001007
formalization submissions, including an earlier-publicized tester-lean proof
now represented by official PR #2284.

This repository therefore does **not** claim:

- mathematical solver priority;
- first-formalization priority;
- an uncontested formalization slot;
- award eligibility merely from publication of this repository.

Maintainers should determine statement correspondence, overlap, attribution,
priority, eligibility, and any award consequence.
