# Attribution

## Mathematical solution

The underlying negative mathematical solution to Erdős Problem #1202 / JSP-001007 is **not claimed as original work by this repository**.

Mathematical solution credit is retained as:

```text
Liam Price and GPT-5.4 Pro
```

as recorded by the Justin Sun Prize problem bank at the time this formalization was prepared.

## Lean formalization

Lean formalization contribution:

```text
GitHub account: e66812162-Liu
Repository: e66812162-Liu/JSP001007-Erdos1202-Lean
```

The repository is the original working repository for this formalization and contains the proof engineering, CI repair history, stable-kernel migration, and verification evidence.

The formalization claim is therefore **Lean formalization only**, not mathematical solver credit.

## Scope of the formalization

The formalization covers the complete negative statement encoded as:

```lean
Erdos1202SourceStatementV11
```

and proves:

```lean
erdos1202_negative_source_faithful_v11 :
  ¬ Erdos1202SourceStatementV11
```

The final review should compare the formal statement with the original Erdős formulation and the JSP problem-bank entry; source-fidelity notes are preserved in the proof development and project records.
