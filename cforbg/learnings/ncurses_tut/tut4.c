/* ncurses tutorial 4 */
#include <ncurses.h>
#include <sys/ioctl.h>

void drawBorder(struct winsize w);

int main(void) {
  struct winsize w;
  /*
   * making a sys-request ( TIOCGWINSZ )
   * to get number of rows and columns
   * of the current terminal window
   */
  ioctl(0, TIOCGWINSZ, &w);

  initscr();
  clear();
  drawBorder(w);

  getch();
  endwin();
  return 0;
}

void drawBorder(struct winsize w) {
  // print top bar
  for (int i = 0; i < w.ws_col; i++) {
    move(0, i);
    printw("#");
  }

  // print bottom bar
  for (int i = 0; i < w.ws_col; i++) {
    move(w.ws_row - 1, i);
    printw("#");
  }

  // print left side bar
  for (int i = 0; i < w.ws_row; i++) {
    move(i, 0);
    printw("#");
  }

  // print right side bar
  for (int i = 0; i < w.ws_row; i++) {
    move(i, w.ws_col - 1);
    printw("#");
  }
}
