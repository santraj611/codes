const std = @import("std");

const failed = error{
    couldNotAllocate,
};

pub fn main() !void {
    // Comments in Zig start with "//" and end at the next LF byte (end of line).
    // The line below is a comment and won't be executed.

    //print("Hello?", .{});

    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    // const name: []u8 = alloc.alloc(u8, 50) catch {
    //     try stdout.print("Failed to Allocate memory\n", .{});
    //     return;
    // };
    // defer alloc.free(name);

    // for (name) |*bytes| {
    //     bytes.* = 0;
    // }

    // Ask user for there name?
    try stdout.print("What is your name?\n--> ", .{});

    // returnValue is same as buffer but only contains bytes that we need
    // not the total bytes metioned at the time of allocating

    // Method 1
    // const returnValue = try stdin.readUntilDelimiterOrEof(name, '\n');

    // Method 2
    const name: []u8 = try stdin.readUntilDelimiterAlloc(alloc, '\n', 100);

    try greet(name);

    try greetInHex(name);

    const zig = [3]u8 { 0x5a, 0x69, 0x67 };
    try stdout.print("Hello ", .{});
    for (zig) |item| {
        try stdout.print("{u}", .{item});
    }
    try stdout.print("\n", .{});
}

/// Greets the person of given name
fn greet(name: []u8) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Hello {s}\n", .{ name });
    try stdout.print("How are you doing\n", .{});
}

// Greeting in Hexadecimal
fn greetInHex(name: []u8) !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("Greetings in Hexadecimal\n", .{});

    for (name) |byte| {
        try stdout.print("{x} ", .{ byte });
    }
    try stdout.print("\n", .{});
}
