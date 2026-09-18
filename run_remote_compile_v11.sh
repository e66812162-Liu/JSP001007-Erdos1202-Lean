#!/usr/bin/env bash
set -uo pipefail

mkdir -p jsp_logs

files=(
  JSP001007_ClusterGapEngine1202_Candidate.lean
  JSP001007_WP4C_PrimeBoxPigeonhole_StaticAuditV4.lean
  JSP001007_WP4C_Arch51_PrimeBox_StaticAuditV4.lean
  JSP001007_WP4P_ClusterToCounterexample_Kernel_V6.lean
  JSP001007_WP4N_DyadicPNTLowerBound_V5.lean
  JSP001007_WP4P_PNT_to_ClusterData_Adapter_V4.lean
  JSP001007_WP4P_SourceFaithful_FinalWrapper_V11.lean
  JSP001007_Master_SourceFaithful_V11.lean
)

echo "=== Environment ===" | tee jsp_logs/00_environment.log
echo "PrimeGapsLib HEAD: $(git rev-parse HEAD)" | tee -a jsp_logs/00_environment.log
echo "Lean toolchain: $(cat lean-toolchain)" | tee -a jsp_logs/00_environment.log
echo "Lake version:" | tee -a jsp_logs/00_environment.log
lake --version 2>&1 | tee -a jsp_logs/00_environment.log || true
echo "Lean version:" | tee -a jsp_logs/00_environment.log
lake env lean --version 2>&1 | tee -a jsp_logs/00_environment.log || true

status=0
for f in "${files[@]}"; do
  log="jsp_logs/${f%.lean}.log"
  echo "======================================================" | tee "$log"
  echo "COMPILING $f" | tee -a "$log"
  echo "======================================================" | tee -a "$log"
  set +e
  lake env lean "$f" 2>&1 | tee -a "$log"
  rc=${PIPESTATUS[0]}
  set -e
  if [ "$rc" -ne 0 ]; then
    echo "FIRST FAILING MODULE: $f" | tee jsp_logs/FIRST_FAILURE.txt
    echo "EXIT CODE: $rc" | tee -a jsp_logs/FIRST_FAILURE.txt
    status=$rc
    break
  fi
done

{
  echo "=== Forbidden token scan ==="
  grep -RInE '\b(sorry|admit|axiom|unsafe|native_decide|skipKernelTC)\b' JSP001007_*.lean || true
} > jsp_logs/forbidden_scan.log

if [ "$status" -eq 0 ]; then
  echo "ALL V11 CANDIDATE MODULES COMPILED" | tee jsp_logs/GREEN.txt
fi

exit "$status"
