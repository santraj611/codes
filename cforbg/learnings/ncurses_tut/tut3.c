/* arrow game */
#include <ncurses.h>
#include <sys/ioctl.h>

int main() {
  struct winsize w;

  ioctl(0, TIOCGWINSZ, &w);

  int key, x, y;
  initscr();
  keypad(stdscr, TRUE);
  noecho();
  clear();

  move(0, 0);
  printw("Press arrow keys to move. Or 'q' to quit.");

  key = getch();
  x = y = 10;

  while (key != 'q') {
    clear();
    move(y, x);
    printw("@");
    refresh();

    key = getch();
    if (key == KEY_RIGHT) {
      x++;
      if (x > w.ws_col - 1)
        x = w.ws_col - 1;
    } else if (key == KEY_LEFT) {
      x--;
      if (x < 0)
        x = 0;
    } else if (key == KEY_DOWN) {
      y++;
      if (y > w.ws_row - 1)
        y = w.ws_row - 1;
    } else if (key == KEY_UP) {
      y--;
      if (y < 0)
        y = 0;
    }
  }

  endwin();
  return 0;
}
