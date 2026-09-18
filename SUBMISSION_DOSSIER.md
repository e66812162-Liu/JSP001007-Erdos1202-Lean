# JSP-001007 submission dossier

This file is a preparation aid for the public Justin Sun Prize repository. It
is not itself an award claim.

## Contribution being submitted

**Lean formalization only.**

Mathematical solver credit is not claimed here. The current mathematical
solution attribution remains Liam Price and GPT-5.4 Pro.

Formalization contributor:

```text
@e66812162-Liu
```

Original public proof repository:

```text
https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean
```

Frozen verified branch:

```text
verified-v12
```

Frozen verified commit:

```text
2e53fb5325604e34311e4600aa9e845fecfda09d
```

Top theorem and file:

```text
JSP001007.erdos1202_negative_public_statement_v12
candidate/JSP001007_Master_SourceFaithful_V12.lean
```

Statement comparison:

```text
STATEMENT_COMPARISON_V12.md
```

## Verification evidence

Stable Lean verification:

```text
Lean 4.34.0
GitHub Actions run 35307229093
```

Independent audit:

```text
GitHub Actions run 35307229141
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
jsp001007-v12-stable434-independent-audit
Artifact ID 10532421526
SHA256 1a75e66e64dd294c1134ea0bc83b263dee95ec5f03fdbedb92a5eb7d81791d40
```

## Competition lock

A fresh search of the official awards repository found overlapping JSP-001007
formalization submissions already under review, including issue #104 / PR #107,
issue #128 / PR #133, and issue #617.

Accordingly, this submission does **not** claim an empty formalization slot,
first-formalization priority, or mathematical novelty.  It asks maintainers to
review this as a distinct complete formalization and determine overlap,
attribution, priority, and eligibility.

See `COMPETITION_LOCK_2026-09-17.md`.

## Proposed external PR

Suggested title:

```text
JSP-001007: submit distinct Lean formalization of the negative answer
```

Use the official PR template and select:

```text
[x] Lean proof or formalization author information
```

Proof source object:

```json
[
  {
    "repository": "https://github.com/e66812162-Liu/JSP001007-Erdos1202-Lean",
    "branch": "verified-v12",
    "commit": "2e53fb5325604e34311e4600aa9e845fecfda09d"
  }
]
```

The PR should identify:

- theorem: `JSP001007.erdos1202_negative_public_statement_v12`;
- file: `candidate/JSP001007_Master_SourceFaithful_V12.lean`;
- statement comparison: `STATEMENT_COMPARISON_V12.md`;
- build / audit evidence: `VERIFICATION.md`;
- attribution evidence: `ATTRIBUTION.md`.

The PR should explicitly acknowledge the existing JSP-001007 submissions and
avoid claiming first-formalization priority.

## Catalog change

Under the current external-submission rules, propose only the allowed catalog
fields.  A conservative Lean-proof field is:

```text
Submitted for maintainer review: distinct Lean formalization of the negative
answer by @e66812162-Liu; stable Lean 4.34.0 verification and statement
comparison are linked from the public proof repository. Organizer verification
pending.
```

Add an Attribution basis field linking the repository's attribution,
statement-comparison, and verification records.  Do not alter eligibility,
index, or award records; maintainers reconcile those after review.

## Award claim

The official claim form is for the actual contributor applying for themselves.
A claim should be filed only after the catalog / contribution evidence has been
reviewed sufficiently for the maintainers to process it.

The issue author must match the owner of the original public proof repository.
A public follow-up email is required at claim time.  Do not publish private
identity documents or payment information.

## Remaining publication actions

1. public proof repository — completed;
2. frozen V12 branch / commit — completed;
3. stable Lean 4.34 verification and independent audit — completed;
4. fork the official `TheJustinSunPrize/awards` repository under
   `e66812162-Liu`;
5. edit only the allowed JSP-001007 catalog fields in the fork;
6. open the external PR using the current official template;
7. after maintainer review, follow the official award-claim process if eligible.
