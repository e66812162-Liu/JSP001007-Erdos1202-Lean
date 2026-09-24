# JSP001007-Erdos1202-Lean

Lean formalization of the negative solution to **Erdős Problem #1202 / Justin Sun Prize problem JSP-001007**.

## Result

The current canonical external-review theorem is:

```lean
JSP001007.erdos1202_negative_public_statement_v14 :
  ¬ Erdos1202SourceStatementV14
```

V14 is the closed-death-audit hardened wrapper.  It retains the current public
"at most ε n" conclusion as `≤ ε * n`, preserves the printed positive
`ε, η` quantifiers, uses literal exact-half cardinality
`2 * card = p - 1`, and explicitly restricts the size parameter to positive
`n`.  It does not add an extra positivity convention on `k`.

The mathematical counterexample is unchanged: a dense short interval of
primes feeds a cluster-gap residue construction whose explicit survivor
rectangle has size strictly greater than `n / 3`.

## Frozen verified source

```text
branch: verified-v14
commit: 2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7
```

Exact top file:

```text
candidate/JSP001007_Master_SourceFaithful_V14.lean
```

That exact proof commit passed stable Lean 4.34.0 compilation, `#print axioms`,
a forbidden-token audit, and an independent `leanchecker` replay.

See [VERIFICATION.md](VERIFICATION.md),
[STATEMENT_COMPARISON_V14.md](STATEMENT_COMPARISON_V14.md), and
[CLOSED_DEATH_AUDIT_V14.md](CLOSED_DEATH_AUDIT_V14.md).

## Closed death audit

Before promoting V14, the project adversarially tested the frozen V12
mathematical core against nearby statement/domain readings.  The same
construction formally refutes:

- the source statement without an added `0 < k` convention;
- the positive-`n` source domain;
- the historical strict terminal inequality `< ε n`;
- the floor-half convention `card = p / 2` on the constructed odd primes.

The audit also formally checks the last-prime/all-primes size-bound bridge and
that the exact-half equation excludes the `p = 2` Nat-truncation ambiguity.

The full closed audit passed Lean 4.34.0 compilation and `leanchecker`.
V14 changes the source wrapper only; the counterexample engine is unchanged.

## Attribution

This repository claims **Lean formalization contribution only**.

The mathematical negative solution remains attributed to **Liam Price and
GPT-5.4 Pro**, consistent with the current JSP problem-bank record.  This
repository does not claim mathematical solver credit or first-formalization
priority.

Formalization contributor / repository owner:

```text
GitHub: e66812162-Liu
```

See [ATTRIBUTION.md](ATTRIBUTION.md).

## Canonical proof chain

The V14 proof uses:

- `JSP001007_ClusterGapEngine1202_Candidate.lean`
- `JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4.lean`
- `JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4.lean`
- `JSP001007_WP4N_DyadicPNTLowerBound_V5.lean`
- `JSP001007_WP4P_ClusterToCounterexample_Kernel_V6.lean`
- `JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4.lean`
- `JSP001007_WP4Q_SourceFaithful_FinalWrapper_V14.lean`
- `JSP001007_Master_SourceFaithful_V14.lean`

The exact review copy is on `verified-v14` at the full commit SHA above.

## Competition note

Other JSP-001007 formalization submissions are under public review, including
the earlier-publicized tester-lean submission now represented by PR #2284.
This repository therefore presents a **distinct complete formalization
contribution** and makes no claim of first-formalization priority.  Priority,
overlap, eligibility, and any award consequence are for the maintainers to
decide.
