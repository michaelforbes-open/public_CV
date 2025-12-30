#!/bin/bash
set -e

echo "--- STEP 1: Compiling Firmware ---"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

echo "--- STEP 2: Running Exploit ---"
# Use --headless to prevent any GUI-related silent crashes
renode-test --headless tests/exploit.robot
