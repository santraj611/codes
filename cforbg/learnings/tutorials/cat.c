#include <stdio.h>

void cat_one();
void cat_two(int n);
void cat_three(int n);
void cat_four(int n);
int get_int(const char *s);

int main(void) {
  // int n = 3;
  // cat_one();
  // cat_two(n);
  // cat_three(n);
  // cat_four(n);

  int n = get_int("Give me a Number: ");
  cat_three(n);

  return 0;
}

void cat_one() {
  printf("Meow!\n");
  printf("Meow!\n");
  printf("Meow!\n");
}

void cat_two(int n) {
  int i = n;
  while (i > 0) {
    printf("Meow!\n");
    i--;
  }
}

void cat_three(int n) {
  int i = 0;
  while (i < n) {
    printf("Meow!\n");
    i++;
  }
}

void cat_four(int n) {
  for (int i = 0; i < n; i++) {
    printf("Meow!\n");
  }
}

int get_int(const char *s) {
  printf("%s", s);
  int num;
  int rs = scanf("%d", &num);

  if (rs != 1) {
    printf("You Broke the code!\n");
    return 0;
  }

  return num;
}
