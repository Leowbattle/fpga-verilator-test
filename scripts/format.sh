#!/usr/bin/env bash
set -euo pipefail

mode="${1:-check}"

cpp_files=$(find test -type f \( -name '*.cpp' -o -name '*.hpp' \))
sv_files=$(find src -type f -name '*.sv')

case "$mode" in
  check)
    if [ -n "$cpp_files" ]; then
      clang-format --dry-run --Werror $cpp_files
    fi
    if [ -n "$sv_files" ]; then
      verible-verilog-format --verify $sv_files
    fi
    ;;
  fix)
    if [ -n "$cpp_files" ]; then
      clang-format -i $cpp_files
    fi
    if [ -n "$sv_files" ]; then
      verible-verilog-format --inplace $sv_files
    fi
    ;;
  *)
    echo "Usage: $0 [check|fix]" >&2
    exit 2
    ;;
esac
