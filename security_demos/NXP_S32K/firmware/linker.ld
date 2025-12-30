MEMORY {
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 512K
    SRAM (rwx) : ORIGIN = 0x1FFF8000, LENGTH = 64K
}
SECTIONS {
    .text : { *(.text*) } > FLASH
}
