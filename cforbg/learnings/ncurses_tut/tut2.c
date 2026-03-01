#include <ncurses.h>

int main() {
    int x, y;

    initscr();
    clear();

    getyx(stdscr, y, x);
    printw(
            "x = %d\n"
            "y = %d",
            x, y
            );
    refresh();

    x = 10;
    y = 5;
    move(y, x);
    printw("Over Here!");
    refresh();


    getyx(stdscr, y, x);
    printw(
            "x = %d\n"
            "y = %d",
            x, y
            );
    refresh();

    getch();
    endwin();

    return 0;
}
