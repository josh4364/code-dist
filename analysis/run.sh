#!/usr/bin/env bash

# This script runs all analysis tools within a Nix shell to refresh graphs and reports.
# Use this after updating source files or tweaking Lumina syntax.

set -e

# Change to the analysis directory if not already there
cd "$(dirname "$0")"

echo "Provisioning Nix shell and running analysis suite..."

nix-shell -p \
    python311Packages.pandas \
    python311Packages.matplotlib \
    python311Packages.seaborn \
    python311Packages.scikit-learn \
    python311Packages.tiktoken \
    --run "
        echo '--- Running Symbol Distribution Analysis ---'
        python3 analyze.py
        
        echo ''
        echo '--- Running LLM Tokenization Analysis ---'
        python3 token_analysis.py
        
        echo ''
        echo 'Analysis complete. Visualizations refreshed in analysis/ folder.'
    "
