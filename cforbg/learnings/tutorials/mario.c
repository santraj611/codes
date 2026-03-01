#include <stdio.h>


int get_int(const char* s);

int main(void) {
    int row = get_int("Give me rows ? ");
    int cols = get_int("Give me colums ? ");

    for (int i = 0; i < row; i++) {
        for (int j = 0; j < cols; j++) {
            printf("#");
        }
        printf("\n");
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