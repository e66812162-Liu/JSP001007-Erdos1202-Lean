# JSP-001007 closed death audit — V12 to V14

Date: 2026-09-24

## Goal

Before relying on the submitted JSP-001007 formalization, the project subjected
its own statement and proof interface to the same adversarial scrutiny used on
competing formalizations.

The audit asked whether the negative result could fail because of:

- an unnecessary positivity convention on `k`;
- the artificial natural-number edge case `n = 0`;
- last-prime versus all-primes formulations of the size bound;
- exact-half versus truncated Nat division;
- historical strict versus current non-strict terminal inequalities;
- the nearby floor-half convention;
- proof-bypass axioms or kernel-replay failure.

## Outcome

No defect was found in the prime-cluster / residue-block / survivor-rectangle
mathematical engine.

Two statement-interface hardening opportunities were identified:

1. V12 explicitly required `0 < k`, although the displayed source can be read
   without adding that separate premise.
2. V12 quantified over all natural `n`, including `0`, whereas the source
   size parameter is naturally positive.

Both were attacked formally rather than repaired by assumption.

## Audit theorems

The audit proved:

```lean
erdos1202_negative_no_kpos_audit
```

so allowing `k = 0` does not rescue the conjecture.

It proved:

```lean
erdos1202_negative_positive_n_audit
erdos1202_negative_historical_positive_n_audit
```

so the counterexample still refutes the positive-`n` source domain, under
both current non-strict and historical strict terminal readings.

It also proved:

```lean
erdos1202_negative_strict_terminal_audit
erdos1202_negative_floor_half_audit
```

and checked:

```lean
strictMono_all_lt_iff_last_lt_audit
exact_half_excludes_two_audit
constructed_n_positive_audit
```

## p = 2 truncation test

The audit explicitly compiled:

```lean
example :
    ∃ A : Finset (ZMod 2),
      A.card = (2 - 1) / 2 ∧
      ¬ (2 * A.card = 2 - 1) := by
  refine ⟨∅, ?_, ?_⟩ <;> norm_num
```

This confirms why the canonical source wrapper uses
`2 * card = p - 1` rather than Nat-truncated division.

## Kernel evidence

Closed death audit workflow:

```text
Run 35953961348
JSP-001007 V12 Closed Death Audit
```

All stages succeeded, including:

- frozen V12 recompilation;
- adversarial statement audit compilation;
- `leanchecker` replay;
- second semantic audit compilation;
- second `leanchecker` replay;
- positive-`n` audit compilation;
- positive-`n` `leanchecker` replay;
- exact Lean 4.34.0 version check.

The audited negative theorems depend only on:

```text
[propext, Classical.choice, Quot.sound]
```

## Promotion decision

The audit led to V14, whose canonical theorem is:

```lean
JSP001007.erdos1202_negative_public_statement_v14 :
  ¬ Erdos1202SourceStatementV14
```

V14 passed candidate verification and a separate robust independent audit at:

```text
verified-v14
2ebb7d6826d0bee041ba89a61804bcf45e2dc7c7
```

The promotion is a statement-domain hardening, not a replacement of the
counterexample mathematics.
