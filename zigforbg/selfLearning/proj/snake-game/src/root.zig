//! By convention, root.zig is the root source file when making a library.
const std = @import("std");
const Snake = @import("snake.zig");

pub fn bufferedPrint() !void {
    // Stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try stdout.flush(); // Don't forget to flush!
}

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try std.testing.expect(add(3, 7) == 10);
}

pub const Vec2 = struct { x: c_int, y: c_int };

/// A cell which makes up the body of snake
/// has icon which represent this cell,
/// It is `-` and it's moving horizontal and `|` when moving vertical.
/// A cell also keeps track of its own position
pub const Cell = struct {
    /// icon when moving horizontilly
    iconx: u8 = '-',
    /// icon when moving vertically
    icony: u8 = '|',

    pos: Vec2,
};

/// Velocity vector direction components
pub const Velocity = enum { i, j };
