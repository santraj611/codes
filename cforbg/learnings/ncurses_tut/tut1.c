/* ncurses.c */
#include <ncurses.h>

int main(int argc, char *argv[]) {
	char letter;

	// initialize a screen to do make a show
	initscr();
	printw("Yo whats up my gang?");
	refresh();

	// get usr key press (char) and print it on the screen
	letter = getch();
	clear();
	printw("did you just pressed '%c'?", letter);
	refresh();

	// so that we don't close the window
	getch();

	// destroy the window or end it
	endwin();

	return 0;
}
