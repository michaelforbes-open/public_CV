#include <stdint.h>

#define LPUART0_BASE 0x4006A000
#define LPUART0_DATA (*(volatile uint32_t*)(LPUART0_BASE + 0x10))
#define LPUART0_STAT (*(volatile uint32_t*)(LPUART0_BASE + 0x14))

void UART_Write(const char* s) {
    while(*s) LPUART0_DATA = *s++;
}

char UART_Read() {
    // Wait for character (Renode handles the timing)
    while(!(LPUART0_STAT & (1 << 21))); 
    return (char)(LPUART0_DATA & 0xFF);
}

void Secret_Backdoor() {
    UART_Write("HACKED\n");
    while(1);
}

void HandleCommand() {
    char buffer[8]; // Small buffer for easy overflow
    int i = 0;
    while (1) {
        char c = UART_Read();
        if (c == '\n' || c == '\r') break;
        buffer[i++] = c; 
    }
}

int main() {
    UART_Write("READY\n");
    while(1) {
        HandleCommand();
        UART_Write("DONE\n");
    }
    return 0;
}
