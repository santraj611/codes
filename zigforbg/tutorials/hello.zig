const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello, World!\n", .{});
}

fn hello() void {
    std.debug.print("Hello, World!\n", .{});
}
