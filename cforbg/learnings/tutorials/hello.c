#include <stdio.h>

int main(void) {
    // ask for name
    printf("What's your name? ");

    // get the name
    const int MAX_SIZE = 30;
    char name[MAX_SIZE];
    int n = scanf("%29s", name);

    // failed to read
    if (n != 1) {
        printf("Shit! You broke me!\n");
        return 1;
    }
    else {
        printf("Hi %s\n", name);
    }

    return 0;
}