#!/usr/bin/env bash
set -uo pipefail

# Resolve relative directories from scripts/ folder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IR_DIR="$SCRIPT_DIR/../ir"
BIN_DIR="$SCRIPT_DIR/../bin"

CLANG="${CLANG:-clang}"

mkdir -p "$BIN_DIR"

if [[ ! -d "$IR_DIR" ]]; then
    echo "Error: IR directory not found at $IR_DIR"
    echo "Run generate_ir.sh first."
    exit 1
fi

shopt -s nullglob
# Find all before.ll files to serve as the reference set
before_files=("$IR_DIR"/*_before.ll)

if [[ ${#before_files[@]} -eq 0 ]]; then
    echo "No _before.ll files found in $IR_DIR"
    exit 1
fi

echo "======================================================="
echo "       IR Differential Execution & Validation          "
echo "======================================================="
printf "%-25s | %-12s | %-12s | %s\n" "C Program File" "Before Output" "After Output" "Status"
echo "-------------------------------------------------------"

total_tests=0
passed_tests=0

for before_ll in "${before_files[@]}"; do
    # Extract the base prefix (e.g., "positive_tests" from "positive_tests_before.ll")
    filename_full="$(basename "$before_ll")"
    base_name="${filename_full%_before.ll}"
    
    after_ll="$IR_DIR/${base_name}_after.ll"

    if [[ ! -f "$after_ll" ]]; then
        printf "%-25s | %-12s | %-12s | ❌ (Missing after.ll)\n" "$base_name" "N/A" "N/A"
        continue
    fi

    bin_before="$BIN_DIR/${base_name}_before_bin"
    bin_after="$BIN_DIR/${base_name}_after_bin"

    # Compile before.ll and after.ll to native binaries
    if ! "$CLANG" "$before_ll" -o "$bin_before" 2>/dev/null || ! "$CLANG" "$after_ll" -o "$bin_after" 2>/dev/null; then
        printf "%-25s | %-12s | %-12s | ❌ (Compilation Error)\n" "$base_name" "Error" "Error"
        continue
    fi

    # Run binaries and capture output
    out_before="$("$bin_before" 2>/dev/null | tr -d '\r')"
    out_after="$("$bin_after" 2>/dev/null | tr -d '\r')"

    total_tests=$((total_tests + 1))

    # Compare execution outputs
    if [[ "$out_before" == "$out_after" ]]; then
        printf "%-25s | %-12s | %-12s | ✅ PASS\n" "$base_name" "$out_before" "$out_after"
        passed_tests=$((passed_tests + 1))
    else
        printf "%-25s | %-12s | %-12s | ❌ FAIL (Mismatch)\n" "$base_name" "$out_before" "$out_after"
    fi
done

echo "======================================================="
echo "Summary: $passed_tests / $total_tests programs matched successfully."
echo "======================================================="

# Exit with error code if any test failed
[[ $passed_tests -eq $total_tests ]]