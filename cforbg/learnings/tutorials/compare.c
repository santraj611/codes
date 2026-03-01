#include <stdio.h>

int get_int(const char* s);

int main(void) {
    int x = get_int("What is x? ");
    int y = get_int("What is y? ");

    if (x < y) {
        printf("x is less then y\n");
    }
    else if (x > y) {
        printf("x is greater then y\n");
    }
    else {
        printf("x is equal to y\n");
    }
    return 0;
}

int get_int(const char* s) {
    printf("%s", s);

    int number;

    int rs = scanf("%i", &number);

    if (rs != 1) {
        printf("Failed to get int as input\n");
        return 0;
    }
    
    return number;
}