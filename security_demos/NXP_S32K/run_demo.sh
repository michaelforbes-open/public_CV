#!/bin/bash
set -e

# 1. Export the absolute path
export PROJECT_ROOT=$(pwd)

echo "--- STEP 1: Compiling Firmware ---"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

echo "--- STEP 2: Running Exploit ---"
# We run renode-test directly on the robot file
renode-test tests/exploit.robot
