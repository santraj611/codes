const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const guess: usize = 7701909097;

    var i: usize = 7700000007;

    while (true) : (i += 10) {
        if (i == guess) {
            print("Found the guess: {}\n", .{i});
            break;
        } else {
            print("{}\n", .{i});
            continue;
        }
    }
}
