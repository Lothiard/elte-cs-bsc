#include <stdio.h>

#define RESET       "\033[0m"
#define BG_BLACK    "\033[40m"
#define BG_RED      "\033[41m"
#define BG_GREEN    "\033[42m"
#define BG_YELLOW   "\033[43m"
#define BG_BLUE     "\033[44m"
#define BG_MAGENTA  "\033[45m"
#define BG_CYAN     "\033[46m"
#define BG_WHITE    "\033[47m"

typedef enum color {
    black,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white
} Color;

void color_print() {
    char input[2];
    fgets(input, 2, stdin);
    
    Color szin = (Color)input;
    
    switch(szin) {
        case 1:
            printf("%s", BG_RED);
            break;
        case 2:
            printf("%s", BG_GREEN);
            break;
        case 3:
            printf("%s", BG_YELLOW);
            break;
        case 4:
            printf("%s", BG_BLUE);
            break;
        case 5:
            printf("%s", BG_MAGENTA);
            break;
        case 6:
            printf("%s", BG_CYAN);
            break;
        case 7:
            printf("%s", BG_WHITE);
            break;
        default:
            printf("helytelen input\n");
            break;
    }
}

int main() {
    color_print();
    
    return 0;
}