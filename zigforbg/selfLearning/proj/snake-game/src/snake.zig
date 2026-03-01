//! This snake strcut provides a snake object
//! which keeps track of it's position, velocity and length

const std = @import("std");
const Snake = @This();

const Allocator = std.mem.Allocator;

const Cell = @import("snake_game").Cell;
const Velocity = @import("snake_game").Velocity;
const Vec2 = @import("snake_game").Vec2;

// A snake has two parts head and body
// initially it only has head
// letter when it eats something it gets body
// body is a collection of cells
// length of the sanke is just, total no of cells attached to head.
body: std.ArrayList(Cell) = .empty,

/// position of the head
head_pos: Vec2,

/// A snake can have velocity in only one direction at a time
vel: Vec2 = undefined,

pub fn init() Snake {
    return .{
        .head_pos = .{ .x = 0, .y = 0 },
    };
}

/// move the snake in the given direction
/// you can call this function every time when there is any keypress
pub fn move(self: *Snake, dir: Velocity) void {
    switch (dir) {
        .i => {
            // move in x dir
            if (self.vel.x != 0) return; // already moving in x cap
            self.vel.y = 0;
            self.vel.x = 1;
        },
        .j => {
            // move in y dir
            if (self.vel.y != 0) return; // already moving in y cap
            self.vel.x = 0;
            self.vel.y = 1;
        },
    }
}

/// when the snake eats anything it's gets longer
/// that extra length (extra character) is added to the tail of the snake
/// which will be a cell (cells make up the body of the snake!)
pub fn eat(self: *Snake, allocator: Allocator) !void {
    // get the position of last cell
    const last = self.body.getLastOrNull();

    if (last) |l| {
        // add a cell where the last cell is (It will be randerd when the snake move forward)
        const new_cell = Cell{ .pos = .{ .x = l.pos.x, .y = l.pos.y } };
        try self.body.append(allocator, new_cell);
    } else {
        const new_cell = Cell{ .pos = .{ .x = self.head_pos.x, .y = self.head_pos.y } };
        try self.body.append(allocator, new_cell);
    }
}

/// This function updates the body of the snake
pub fn update(self: *Snake, head_pos: Vec2) void {
    // save old position for the body
    var old: Vec2 = self.head_pos;

    // update head position with the new position
    self.head_pos = head_pos;

    // update the body cells
    for (self.body.items) |*cell| {
        const tmp: Vec2 = cell.pos;
        cell.pos = old;
        old = tmp;
    }
}

pub fn destroy(self: *Snake, allocator: Allocator) void {
    self.body.deinit(allocator);
}
