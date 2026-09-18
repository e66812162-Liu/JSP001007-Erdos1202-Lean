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

This repository is the original working repository for this formalization and
contains the proof engineering history, stable-kernel migration, statement
comparison, and verification evidence.

The contribution claim is therefore **Lean formalization only**, not
mathematical solver credit.

## Scope

The canonical external-review theorem is:

```lean
JSP001007.erdos1202_negative_public_statement_v12 :
  ¬ Erdos1202SourceStatementV12
```

V12 directly formalizes the current public "at most ε n" terminal condition as
`≤ ε * n`.  See `STATEMENT_COMPARISON_V12.md`.

## Priority / overlap disclaimer

Public searches of the official awards repository show other JSP-001007
formalization submissions already under review.  This repository therefore does
**not** claim first-formalization priority or an uncontested formalization slot.

Maintainers should decide overlap, attribution, priority, eligibility, and any
award consequence.
