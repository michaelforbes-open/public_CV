#!/bin/bash
set -e
# Clean old files
rm -f firmware/vulnerable.elf

echo "--- STEP 1: Compiling ---"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

echo "--- STEP 2: Running Exploit ---"
renode-test --headless tests/exploit.robot
