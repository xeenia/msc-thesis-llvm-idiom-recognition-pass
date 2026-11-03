#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Allow overriding LLVM binaries via env vars, fallback to local build or PATH
LLVM_BIN="${LLVM_BIN:-/home/xenia/Projects/llvm-project/build/bin}"
OPT="${OPT:-$LLVM_BIN/opt}"
FILECHECK="${FILECHECK:-$LLVM_BIN/FileCheck}"
PLUGIN="${PLUGIN:-$ROOT_DIR/../build/PatternSelectPass.so}"

# Fallback to system PATH if custom dir doesn't exist
command -v "$OPT" >/dev/null 2>&1 || OPT="opt"
command -v "$FILECHECK" >/dev/null 2>&1 || FILECHECK="FileCheck"

if [[ ! -f "$PLUGIN" ]]; then
    echo "Error: Plugin not found at $PLUGIN. Build the project first."
    exit 1
fi

echo "=== Running LLVM PatternSelect Regression Suite ==="
PASS_COUNT=0
FAIL_COUNT=0

TMP_CLEAN=$(mktemp /tmp/pattern_clean.XXXXXX.ll)
TMP_FINAL=$(mktemp /tmp/pattern_final.XXXXXX.ll)
trap 'rm -f "$TMP_CLEAN" "$TMP_FINAL"' EXIT

# Updated path to point to checkfileversion folder
for test_file in "$SCRIPT_DIR"/../checkfileversion/*.ll; do
    if [[ ! -f "$test_file" ]]; then
        echo "No test files found in checkfileversion directory."
        break
    fi

    printf "Testing %-25s ... " "$(basename "$test_file")"

    if ! "$OPT" -passes="mem2reg,simplifycfg" -S < "$test_file" > "$TMP_CLEAN" 2>/dev/null; then
        echo "PREPROCESS ERROR ❌"
        ((FAIL_COUNT++))
        continue
    fi

    if ! "$OPT" -load-pass-plugin="$PLUGIN" -passes="pattern-select" -S < "$TMP_CLEAN" > "$TMP_FINAL" 2>/dev/null; then
        echo "PASS CRASH 💥"
        ((FAIL_COUNT++))
        continue
    fi

    if "$FILECHECK" "$test_file" < "$TMP_FINAL"; then
        echo "PASS ✅"
        ((PASS_COUNT++))
    else
        echo "FAIL ❌"
        ((FAIL_COUNT++))
    fi
done

echo "---------------------------------------------------"
echo "Summary: $PASS_COUNT passed, $FAIL_COUNT failed."
[[ $FAIL_COUNT -eq 0 ]]