#!/bin/bash
set -e

# 1. Get the absolute path of the current directory
export PROJ_PATH=$(pwd)
echo "Project Path: $PROJ_PATH"

# 2. Compile the firmware
echo "--- STEP 1: Compiling ---"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

# 3. Run the test with the 'include-log' flag
echo "--- STEP 2: Running Exploit ---"
renode-test --show-log tests/exploit.robot
