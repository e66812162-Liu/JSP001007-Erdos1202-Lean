# JSP001007-Erdos1202-Lean

Lean formalization of the negative solution to **Erdős Problem #1202 / Justin Sun Prize problem JSP-001007**.

## Result

The current canonical top-level theorem is:

```lean
JSP001007.erdos1202_negative_public_statement_v12 :
  ¬ Erdos1202SourceStatementV12
```

V12 aligns the terminal density condition with the current public wording
"at most ε n" by formalizing it as `≤ ε * n`.

The proof uses a dense short interval of primes, a cluster-gap residue
construction, and a dyadic prime-number-theorem estimate.

## Verified source

Frozen verified branch:

```text
verified-v12
```

Verified proof commit:

```text
2e53fb5325604e34311e4600aa9e845fecfda09d
```

That exact commit passed stable **Lean 4.34.0** full-chain verification and an
independent audit including `leanchecker`.

See [VERIFICATION.md](VERIFICATION.md) and
[STATEMENT_COMPARISON_V12.md](STATEMENT_COMPARISON_V12.md).

## Attribution

This repository claims **Lean formalization contribution only**.

The mathematical negative solution remains attributed to **Liam Price and
GPT-5.4 Pro**, consistent with the current JSP problem-bank record. This
repository does not claim mathematical solver credit or first-formalization
priority.

Formalization contributor / repository owner:

```text
GitHub: e66812162-Liu
```

See [ATTRIBUTION.md](ATTRIBUTION.md).

## Proof layout

The canonical V12 chain is:

- `JSP001007_ClusterGapEngine1202_Candidate.lean`
- `JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4.lean`
- `JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4.lean`
- `JSP001007_WP4N_DyadicPNTLowerBound_V5.lean`
- `JSP001007_WP4P_ClusterToCounterexample_Kernel_V6.lean`
- `JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4.lean`
- `JSP001007_WP4Q_SourceFaithful_FinalWrapper_V12.lean`
- `JSP001007_Master_SourceFaithful_V12.lean`

## Verification status

Stable Lean 4.34.0 verification established:

- complete V12 proof chain compiles;
- top-level theorem is accepted;
- `#print axioms` reports only `propext`, `Classical.choice`, and `Quot.sound`;
- source audit finds no `sorry`, `admit`, project `axiom`, `unsafe`,
  `native_decide`, or `skipKernelTC` in the JSP source;
- independent `leanchecker` replay succeeds.

Any JSP attribution, overlap, priority, eligibility, or award decision remains
subject to maintainer review.

## Competition note

Other JSP-001007 formalization submissions are already under public review.
This repository therefore presents itself as a **distinct complete
formalization contribution**, not as an uncontested or first formalization.

See [COMPETITION_LOCK_2026-09-17.md](COMPETITION_LOCK_2026-09-17.md).
