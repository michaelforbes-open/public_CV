#!/bin/bash
# 1. Compile the vulnerable firmware
arm-none-eabi-gcc -fno-stack-protector -z execstack -mcpu=cortex-m4 \
    -T firmware/linker.ld firmware/main.c -o firmware/vulnerable.elf -nostartfiles

# 2. Run the automated exploit via Robot Framework
# This will show the logs directly in the terminal
renode-test tests/exploit.robot
