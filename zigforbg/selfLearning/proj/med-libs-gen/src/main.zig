const std = @import("std");

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const name: []u8 = allocator.alloc(u8, 64) catch |err| switch (err) {
        error.OutOfMemory => {
            std.debug.print("we are out of memory try again later\n", .{});
            return err;
        },
        else => return err,
    };
    defer allocator.free(name);

    for (0..name.len) |i| {
        name[i] = 0; // initialized all fileds with zero
    }

    try stdout.print("Hey what's your name?\n", .{});
    _ = try stdin.readUntilDelimiterOrEof(name, '\n');
    try stdout.print("You are soo cool {s}\n", .{name[0 .. name.len - 1]});

    for (name, 0..) |n, i| {
        if (n == '\n') break;
        std.debug.print("{d} : {u}\n", .{ i, n });
    }
}
