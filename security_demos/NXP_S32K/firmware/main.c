#include <stdint.h>

// Mock UART registers for S32K144 LPUART0
#define LPUART0_BASE 0x4006A000
#define LPUART0_DATA (*(volatile uint32_t*)(LPUART0_BASE + 0x10))
#define LPUART0_STAT (*(volatile uint32_t*)(LPUART0_BASE + 0x14))

void UART_Write(const char* s) {
    while(*s) {
        while(!(LPUART0_STAT & (1 << 23))); // Wait for TX empty
        LPUART0_DATA = *s++;
    }
}

char UART_Read() {
    while(!(LPUART0_STAT & (1 << 21))); // Wait for RX full
    return (char)(LPUART0_DATA & 0xFF);
}

// THE TARGET: This function represents a "malicious" action
void Secret_Backdoor() {
    UART_Write("\r\n[!] CRITICAL: EXPLOIT SUCCESSFUL. ACCESS GRANTED.\r\n");
    while(1);
}

// THE VULNERABILITY: No bounds check on 'buffer'
void HandleCommand() {
    char buffer[16]; 
    int i = 0;
    char c;

    UART_Write("Enter Command: ");
    
    // Vulnerable loop: reads until newline
    while ((c = UART_Read()) != '\n' && c != '\r') {
        buffer[i++] = c; 
    }
    buffer[i] = '\0';
}

int main() {
    UART_Write("S32K144 Secure Boot System Initialized.\r\n");
    while(1) {
        HandleCommand();
        UART_Write("Command Processed.\r\n");
    }
}
