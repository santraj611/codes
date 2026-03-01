#include <ncurses.h>
#include <stdio.h>

int main() {
  initscr();
  echo();
  keypad(stdscr, true);

  move(0, 0);
  printw("cool or hot?");

  char choice[4];

  int i = 0;
  while (true) {
    move(1, i);
    refresh();
    int key = getch();
    choice[i] = key;
    if (key == 27) {
      break;
    }
    i++;
  }

  endwin();
  printf("your choice was %s\n", choice);
  return 0;
}
