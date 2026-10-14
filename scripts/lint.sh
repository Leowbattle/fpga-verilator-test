#!/usr/bin/env bash
set -euo pipefail

top_module=alu

sv_files=$(find src -type f -name '*.sv')
if [ -n "$sv_files" ]; then
  verilator --lint-only -Wall --top-module "$top_module" $sv_files
fi
