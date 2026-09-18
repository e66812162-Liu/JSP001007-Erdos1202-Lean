# JSP-001007 Competition Lock — 2026-09-17

## Current official catalog state

The official Justin Sun Prize catalog currently records JSP-001007 as:

- Current status: Solved;
- mathematical proof contributors: Liam Price and GPT-5.4 Pro;
- Lean proof: No;
- Eligible to claim: No.

## Existing public Lean/formalization submissions found

A fresh search of the official awards repository found overlapping public submissions already under review:

1. Issue #104 / PR #107 — half-residue sieve counterexample formalization.
2. Issue #128 / PR #133 — separate square-block formalization contribution.
3. Issue #617 — explicit fixed-N finite certificate, which explicitly acknowledges #104/#107 and #128/#133.

PR #107 and PR #133 are currently open and unmerged.

## Consequence for this repository

This repository must **not** claim that JSP-001007 has an empty or uncontested Lean-formalization slot, and must **not** claim first-formalization priority without separate documentary evidence.

Its submission position is instead:

- a distinct complete Lean formalization of the negative answer;
- direct source-oriented statement `Erdos1202SourceStatementV11`;
- stable Lean 4.34.0 full compilation;
- frozen dependency revisions;
- forbidden-token audit;
- successful Lean kernel checker replay;
- separate attribution to @e66812162-Liu for this formalization only.

The mathematical solution attribution remains Liam Price and GPT-5.4 Pro.

## Submission strategy

Before an external PR:

1. make the proof repository public;
2. verify public access to branch `verified-v11` and commit `04d983cf27a29cb403a192a73fedc961d84b9e25`;
3. cite the existing JSP-001007 submissions in the PR body;
4. request review as a distinct formalization contribution rather than presenting the slot as empty;
5. let maintainers decide overlap, priority, attribution, and eligibility.

This file is a competition-status record, not an award or priority claim.
