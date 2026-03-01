#include <stdio.h>

int get_char(const char* s);

int main(void) {
    char ans = get_char("Are you a human? ");

    if (ans == 'y' || ans == 'Y') {
        printf("Good!\n");
        return 0;
    } else {
        printf("Get out!\n");
        return 1;
    }
}

int get_char(const char* s) {
    printf("%s", s);

    char ans;

    int rs = scanf("%c", &ans);

    if (rs != 1) {
        printf("Failed to get char as input\n");
        return 0;
    }
    
    return ans;
}