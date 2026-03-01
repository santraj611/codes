const std = @import("std");

const snake_game = @import("snake_game");
const Vec2 = snake_game.Vec2;
const Velocity = snake_game.Velocity;

const Snake = @import("snake.zig");

const ncc = @cImport({
    @cInclude("ncurses.h");
});

pub fn main() !void {
    const gpa = std.heap.smp_allocator;

    _ = ncc.initscr();
    defer _ = ncc.endwin();

    _ = ncc.curs_set(0);
    _ = ncc.noecho();
    _ = ncc.keypad(ncc.stdscr, true);
    _ = ncc.clear();

    var snake: Snake = .init();
    defer snake.destroy(gpa);
    try snake.eat(gpa);
    try snake.eat(gpa);
    try snake.eat(gpa);

    _ = ncc.move(snake.head_pos.y, snake.head_pos.x);
    _ = ncc.printw("Use arrow keys for the game and \"q\" to quit.");
    var key = ncc.getch();

    // set velocity in the direction corresponding with the key
    switch (key) {
        ncc.KEY_RIGHT => {
            snake.vel.x = 1;
        },
        ncc.KEY_LEFT => {
            snake.vel.x = -1;
        },
        ncc.KEY_DOWN => {
            snake.vel.y = 1;
        },
        ncc.KEY_UP => {
            snake.vel.y = -1;
        },
        else => {
            snake.vel.x = 1; // default direction
        },
    }

    while (key != 'q') {
        _ = ncc.clear();
        _ = ncc.move(snake.head_pos.y, snake.head_pos.x);
        _ = ncc.printw("@");
        _ = ncc.refresh();

        key = ncc.getch();
        const maxx: c_int = ncc.getmaxx(ncc.stdscr);
        const maxy: c_int = ncc.getmaxy(ncc.stdscr);

        if (key == ncc.KEY_RIGHT) {
            // snake.head_pos.x += 1;
            snake.update(.{
                .x = snake.head_pos.x + 1,
                .y = snake.head_pos.y,
            });
            if (snake.head_pos.x > maxx - 1)
                // snake.head_pos.x = maxx - 1;
                snake.update(.{
                    .x = maxx - 1,
                    .y = snake.head_pos.y,
                });
        } else if (key == ncc.KEY_LEFT) {
            // snake.head_pos.x -= 1;
            snake.update(.{
                .x = snake.head_pos.x - 1,
                .y = snake.head_pos.y,
            });
            if (snake.head_pos.x < 0)
                // snake.head_pos.x = 0;
                snake.update(.{
                    .x = 0,
                    .y = snake.head_pos.y,
                });
        } else if (key == ncc.KEY_DOWN) {
            // snake.head_pos.y += 1;
            snake.update(.{
                .x = snake.head_pos.x,
                .y = snake.head_pos.y + 1,
            });
            if (snake.head_pos.y > maxy - 1)
                // snake.head_pos.y = maxy - 1;
                snake.update(.{
                    .x = snake.head_pos.x,
                    .y = maxy - 1,
                });
        } else if (key == ncc.KEY_UP) {
            // snake.head_pos.y -= 1;
            snake.update(.{
                .x = snake.head_pos.x,
                .y = snake.head_pos.y - 1,
            });
            if (snake.head_pos.y < 0)
                // snake.head_pos.y = 0;
                snake.update(.{
                    .x = snake.head_pos.x,
                    .y = 0,
                });
        }

        // sleep for 0.5 second
        var timespec: std.posix.timespec = .{ .sec = 0, .nsec = 500_000_000 };
        _ = std.posix.system.nanosleep(&timespec, &timespec);
    }
}
