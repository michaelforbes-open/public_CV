#!/bin/bash
# 1. Compile the vulnerable firmware
echo "-------------------------------------------------------"
echo "STEP 1: Compiling vulnerable S32K144 Firmware..."
echo "-------------------------------------------------------"
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

# 2. Run the automated exploit via Robot Framework
# This will show the logs directly in the terminal
echo ""
echo "-------------------------------------------------------"
echo "STEP 2: Launching Renode and running the Buffer Overflow Exploit..."
echo "-------------------------------------------------------"
renode-test tests/exploit.robot
