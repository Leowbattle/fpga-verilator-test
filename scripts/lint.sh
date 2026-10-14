#!/usr/bin/env bash
set -euo pipefail

top_module=top

# Parse dependencies before the top: top.sv uses declarations (such as the
# `alu_op` typedef in alu.sv) from the modules it instantiates, and those must
# be seen first. `find` returns filesystem order, so sort and append the top.
sv_files=$(find src -type f -name '*.sv' ! -name "${top_module}.sv" | sort)
sv_files="$sv_files src/${top_module}.sv"

if [ -n "$sv_files" ]; then
  verilator --lint-only -Wall --top-module "$top_module" $sv_files
fi
