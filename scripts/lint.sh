#!/usr/bin/env bash
set -euo pipefail

sv_files=$(find src -type f -name '*.sv')
if [ -n "$sv_files" ]; then
  verilator --lint-only -Wall $sv_files
fi
