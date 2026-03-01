const std = @import("std");
const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

const nameError = error{ NoName, NoValidName, AllocationFaildForName };

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // ask for user name?
    try stdout.print("What is your name?\n", .{});

    // get user name
    const name: []u8 = try getUserName(allocator);

    // greet user
    try greetUser(name);
}

fn greetUser(name: []const u8) !void {
    if (name.len <= 0) {
        return nameError.NoName;
    }
    try stdout.print("Hello {s}", .{name});
}

fn getUserName(allocator: std.mem.Allocator) ![]u8 {
    const name: []u8 = try stdin.readUntilDelimiterAlloc(allocator, '\n', 100);
    return name;
}
