#include <stdint.h>

// 1. Minimal Vector Table for S32K144
void Reset_Handler(void);
__attribute__((section(".vectors"), used))
uint32_t const * const vector_table[] = {
    (uint32_t *)0x20007000, // Initial Stack Pointer (Top of SRAM)
    (uint32_t *)Reset_Handler  // Reset Vector
};

// 2. UART Registers
#define LPUART0_BASE 0x4006A000
#define LPUART0_DATA (*(volatile uint32_t*)(LPUART0_BASE + 0x10))
#define LPUART0_STAT (*(volatile uint32_t*)(LPUART0_BASE + 0x14))

void UART_Write(const char* s) {
    while(*s) {
        while(!(LPUART0_STAT & (1 << 23)));
        LPUART0_DATA = *s++;
    }
}

char UART_Read() {
    while(!(LPUART0_STAT & (1 << 21)));
    return (char)(LPUART0_DATA & 0xFF);
}

void Secret_Backdoor() {
    UART_Write("\r\n[!] CRITICAL: EXPLOIT SUCCESSFUL. ACCESS GRANTED.\r\n");
    while(1);
}

void HandleCommand() {
    char buffer[16]; 
    int i = 0;
    char c;
    UART_Write("Enter Command: ");
    while ((c = UART_Read()) != '\n' && c != '\r') {
        buffer[i++] = c; 
    }
    buffer[i] = '\0';
}

void Reset_Handler(void) {
    UART_Write("S32K144 Secure Boot System Initialized.\r\n");
    while(1) {
        HandleCommand();
        UART_Write("Command Processed.\r\n");
    }
}

// Dummy main for the compiler
int main() { Reset_Handler(); return 0; }
