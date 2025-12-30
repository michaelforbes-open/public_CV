#!/bin/bash
set -e

echo "--- DIAGNOSTICS ---"
echo "Renode version: $(renode --version)"
echo "Current Dir: $(pwd)"
echo "Checking files:"
ls -l firmware/vulnerable.elf scripts/s32k144.repl tests/exploit.robot

echo "--- RUNNING TEST ---"
# -v means Verbose (shows Robot Framework internal steps)
# --show-log prints the Renode log to the terminal if it fails
renode-test -v --show-log tests/exploit.robot
