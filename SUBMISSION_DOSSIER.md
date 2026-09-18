# JSP-001007 submission dossier

This file is a preparation aid for the public Justin Sun Prize repository. It is not itself an award claim.

## Contribution being submitted

**Lean formalization only.**

Mathematical solver credit is not claimed here. The current mathematical solution attribution remains Liam Price and GPT-5.4 Pro.

Formalization contributor:

```text
@e66812162-Liu
```

Original proof repository:

```text
https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean
```

Frozen verified branch:

```text
verified-v11
```

Frozen verified commit:

```text
04d983cf27a29cb403a192a73fedc961d84b9e25
```

Top theorem and file:

```text
JSP001007.erdos1202_negative_source_faithful_v11
candidate/JSP001007_Master_SourceFaithful_V11.lean
```

## Verification evidence

Stable Lean verification:

```text
Lean 4.34.0
GitHub Actions run 35302485999
```

Independent audit:

```text
GitHub Actions run 35303092340
```

The independent audit passed:

- full stable-4.34 proof compilation;
- `#print axioms`;
- forbidden-token scan;
- independent `leanchecker`.

Axiom output:

```text
[propext, Classical.choice, Quot.sound]
```

Forbidden-token result:

```text
No forbidden proof-bypass tokens found in JSP source.
```

Independent audit artifact:

```text
jsp001007-v11-stable434-independent-audit
Artifact ID 10531041274
SHA256 9e9b4c4883f16582cced05c883a3a995b63797dda304132e546bf584cbc25bf7
```

## Competition lock

A fresh official-repository search found existing overlapping JSP-001007 formalization submissions already under review, including issue #104 / PR #107, issue #128 / PR #133, and issue #617.

Accordingly, this repository does **not** claim an empty formalization slot or first-formalization priority. The external submission should identify this work as a distinct complete formalization and ask maintainers to review overlap, attribution, priority, and eligibility.

See `COMPETITION_LOCK_2026-09-17.md`.

## Proposed external PR information

The Justin Sun Prize contribution instructions request references and catalog text only; the Lean source remains in this repository.

Suggested PR title:

```text
JSP-001007: add Lean formalization of the negative solution
```

Suggested PR body:

```text
This PR records a complete Lean formalization of the existing negative solution to JSP-001007 / Erdős Problem #1202.

Contribution role: Lean formalization only.
Formalization contributor: @e66812162-Liu

Original proof repository:
https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean

Branch: verified-v11
Commit: 04d983cf27a29cb403a192a73fedc961d84b9e25

Top theorem:
JSP001007.erdos1202_negative_source_faithful_v11

Top file:
candidate/JSP001007_Master_SourceFaithful_V11.lean

Build / verification:
See VERIFICATION.md in the proof repository. The complete proof chain compiles under Lean 4.34.0, the source contains no proof-bypass tokens, and an independent leanchecker run succeeds.

Mathematical solver attribution is unchanged: Liam Price and GPT-5.4 Pro. This PR claims no mathematical solver credit.
```

Suggested catalog change for the JSP-001007 row:

```text
Lean proof | Yes — Lean source
Formalization contributors: @e66812162-Liu.
```

Maintainers should reconcile eligibility/index fields after review, as required by their contribution guide.

## Award-claim issue after catalog review

The official claim form requires the actual contributor to apply using the same GitHub account that owns the original public proof repository.

Planned contribution type:

```text
Lean formalization
```

Problem link:

```text
https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-1001-1022.md#jsp-001007
```

Original Lean proof repository:

```text
https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean
```

Identity-verification field may be left blank for a Lean-only application only if source attribution clearly establishes the account-to-author connection.

A public follow-up email must be supplied by the applicant at claim time. Do not put private identity documents or payment information in the public issue.

Related claims / conflicts:

```text
No mathematical solver credit is claimed. Mathematical solution attribution remains Liam Price and GPT-5.4 Pro.
```

## Remaining publication actions

Before opening the external PR:

1. change this proof repository from Private to Public;
2. verify that `verified-v11` and commit `04d983cf27a29cb403a192a73fedc961d84b9e25` are publicly reachable;
3. optionally create a release/tag for that frozen commit;
4. open the catalog PR from the applicant's GitHub account;
5. after maintainer review establishes Lean attribution, submit the award-claim issue with a public follow-up email.
