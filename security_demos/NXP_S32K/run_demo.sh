#!/bin/bash
set -e

echo "--- STEP 1: Compiling ---"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

echo "--- STEP 2: Running Exploit ---"
# We use --show-log to see exactly why Renode might be failing internally
renode-test --show-log tests/exploit.robot
