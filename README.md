# JSP001007-Erdos1202-Lean

Lean formalization of the negative solution to **Erdős Problem #1202 / Justin Sun Prize problem JSP-001007**.

## Result

The formalized top-level theorem is:

```lean
JSP001007.erdos1202_negative_source_faithful_v11 :
  ¬ Erdos1202SourceStatementV11
```

The proof formalizes a counterexample architecture using a dense short interval of primes, a cluster-gap residue construction, and a dyadic prime-number-theorem estimate.

## Verified source

The frozen proof snapshot is the branch:

```text
verified-v11
```

pointing to commit:

```text
04d983cf27a29cb403a192a73fedc961d84b9e25
```

That exact snapshot completed an independent stable-kernel audit under **Lean 4.34.0**.

Verification details and pinned dependency revisions are recorded in [VERIFICATION.md](VERIFICATION.md).

## Attribution

This repository claims **Lean formalization contribution only**.

The mathematical negative solution is attributed to **Liam Price and GPT-5.4 Pro**, consistent with the current JSP problem-bank record. This repository does not claim original mathematical solver credit.

Lean formalization contributor / repository owner:

```text
GitHub: e66812162-Liu
```

See [ATTRIBUTION.md](ATTRIBUTION.md).

## Proof layout

The proof is modularized into:

- `JSP001007_ClusterGapEngine1202_Candidate.lean`
- `JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4.lean`
- `JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4.lean`
- `JSP001007_WP4N_DyadicPNTLowerBound_V5.lean`
- `JSP001007_WP4P_ClusterToCounterexample_Kernel_V6.lean`
- `JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4.lean`
- `JSP001007_WP4P_SourceFaithful_FinalWrapper_V11.lean`
- `JSP001007_Master_SourceFaithful_V11.lean`

## Verification status

Stable Lean 4.34.0 verification established:

- complete V11 proof chain compiles;
- top-level theorem is accepted;
- `#print axioms` reports only `propext`, `Classical.choice`, and `Quot.sound`;
- source audit finds no `sorry`, `admit`, `axiom`, `unsafe`, `native_decide`, or `skipKernelTC` in the JSP proof source;
- independent `leanchecker` run succeeds.

These checks establish a reproducible formal-verification record; any JSP award or formalizer-credit decision remains subject to the maintainers' review.
