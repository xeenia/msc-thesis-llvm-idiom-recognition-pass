#!/usr/bin/env bash
set -euo pipefail

# Resolve relative directories from the scripts/ folder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/../src"
IR_DIR="$SCRIPT_DIR/../ir"
PLUGIN="$SCRIPT_DIR/../../build/PatternSelectPass.so"

# Allow overriding clang/opt via environment variables, fallback to PATH
CLANG="${CLANG:-clang}"
OPT="${OPT:-opt}"

# Ensure output directory exists
mkdir -p "$IR_DIR"

if [[ ! -f "$PLUGIN" ]]; then
    echo "Error: Pass plugin not found at $PLUGIN"
    echo "Please build the project first (e.g., cmake --build ../build)."
    exit 1
fi

shopt -s nullglob
c_files=("$SRC_DIR"/*.c)

if [[ ${#c_files[@]} -eq 0 ]]; then
    echo "No .c files found in $SRC_DIR"
    exit 1
fi

echo "=== Generating IR files into $IR_DIR ==="

for c_file in "${c_files[@]}"; do
    # Extract base filename without extension (e.g., "positive_tests")
    base_name="$(basename "$c_file" .c)"
    
    raw_ir="$IR_DIR/${base_name}_raw.ll"
    before_ir="$IR_DIR/${base_name}_before.ll"
    after_ir="$IR_DIR/${base_name}_after.ll"

    echo "---------------------------------------------------"
    echo "Processing: $(basename "$c_file")"

    # 1. Generate Raw IR (-O0 without optnone so opt passes can run)
    "$CLANG" -S -emit-llvm -Xclang -disable-O0-optnone "$c_file" -o "$raw_ir"
    echo "  [1/3] Created ${base_name}_raw.ll"

    # 2. Generate Before IR (Canonical SSA via mem2reg and simplifycfg)
    "$OPT" -passes="mem2reg,simplifycfg" "$raw_ir" -S -o "$before_ir"
    echo "  [2/3] Created ${base_name}_before.ll"

    # 3. Generate After IR (Run custom pattern-select pass with stats)
    "$OPT" -load-pass-plugin="$PLUGIN" -passes="pattern-select" -stats "$before_ir" -S -o "$after_ir"
    echo "  [3/3] Created ${base_name}_after.ll"
done

echo "---------------------------------------------------"
echo "Done! All IR files saved in: $IR_DIR"