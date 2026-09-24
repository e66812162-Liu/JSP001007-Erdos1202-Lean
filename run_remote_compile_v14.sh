#!/usr/bin/env bash
set -uo pipefail
mkdir -p jsp_logs
files=(
  JSP001007_WP4N_DyadicPNTLowerBound_V5.lean
  JSP001007_ClusterGapEngine1202_Candidate.lean
  JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4.lean
  JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4.lean
  JSP001007_WP4P_ClusterToCounterexample_Kernel_V6.lean
  JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4.lean
  JSP001007_WP4Q_SourceFaithful_FinalWrapper_V14.lean
  JSP001007_Master_SourceFaithful_V14.lean
)
mkdir -p .lake/build/lib/lean
lake build PrimeGapsTheory.NumberTheory.DyadicPNT PrimeGapsTheory.NumberTheory.PrimeCountingInterval
for f in "${files[@]}"; do
  out=".lake/build/lib/lean/${f%.lean}.olean"
  lake env lean -o "$out" "$f" 2>&1 | tee "jsp_logs/${f%.lean}.log" || exit ${PIPESTATUS[0]}
done
echo "ALL V14 CANDIDATE MODULES COMPILED" | tee jsp_logs/GREEN.txt
