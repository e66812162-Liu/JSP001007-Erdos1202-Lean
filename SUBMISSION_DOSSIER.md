# JSP-001007 submission dossier

This file is a preparation aid for the public Justin Sun Prize repository. It
is not itself an award claim.

## Contribution

**Lean formalization only.**

Mathematical solver credit remains Liam Price and GPT-5.4 Pro.

Formalization contributor:

```text
@e66812162-Liu
```

Public proof repository:

```text
https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean
```

Canonical frozen review source:

```text
branch: verified-v14
commit: 2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7
```

Top theorem and file:

```text
JSP001007.erdos1202_negative_public_statement_v14
candidate/JSP001007_Master_SourceFaithful_V14.lean
```

## Verification evidence

V14 candidate verification:

```text
Run 35954341357 — success
```

V14 robust independent audit:

```text
Run 35954341376 — success
Artifact: jsp001007-v14-robust-audit
Artifact ID: 10789856945
SHA256: 8a736a30c863cbeba3cff674d7add71c2b22b3d61d5dc7f6ddac05fc99634695
```

Closed adversarial statement audit:

```text
Run 35953961348 — success
```

The canonical theorem reports only:

```text
[propext, Classical.choice, Quot.sound]
```

The canonical chain contains no `sorry`, `admit`, `unsafe`,
`native_decide`, or `skipKernelTC`, and the master module passes
`leanchecker`.

See:

- `VERIFICATION.md`
- `STATEMENT_COMPARISON_V14.md`
- `CLOSED_DEATH_AUDIT_V14.md`
- `ATTRIBUTION.md`

## Competition position

JSP-001007 is a crowded formalization track.  The tester-lean submission has an
earlier public proof history and is currently represented by official PR #2284.
Other historical submissions have also existed.

This repository does **not** claim first-formalization priority.  The V14
promotion is intended to give maintainers a source-faithful, adversarially
audited review target.  Priority and eligibility remain for official review.

## Existing official submission

Our official awards PR is:

```text
TheJustinSunPrize/awards #1026
```

It should reference the canonical V14 source object:

```json
[
  {
    "repository": "https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean",
    "branch": "verified-v14",
    "commit": "2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7"
  }
]
```

Recommended theorem/file references:

- theorem: `JSP001007.erdos1202_negative_public_statement_v14`;
- file: `candidate/JSP001007_Master_SourceFaithful_V14.lean`;
- statement comparison: `STATEMENT_COMPARISON_V14.md`;
- death audit: `CLOSED_DEATH_AUDIT_V14.md`;
- verification: `VERIFICATION.md`;
- attribution: `ATTRIBUTION.md`.

The PR should continue to acknowledge overlapping submissions and should not
alter eligibility or award records.

## Award claim

Do not file an award claim while the official catalog still marks the Lean
contribution as unaccepted / ineligible.  A claim should follow the official
process only if maintainer review creates an eligible contribution state.
