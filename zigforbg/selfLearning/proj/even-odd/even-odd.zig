const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator: Allocator = gpa.allocator();

    // get user input
    std.debug.print("Enter a number: ", .{});
    const number: u32 = try getIntFromUser(allocator);
    std.debug.print("\n", .{});

    // check if it's even or odd
    if (number % 2 == 0) {
        std.debug.print("{} is even\n", .{number});
    } else {
        std.debug.print("{} is odd\n", .{number});
    }
}

fn getIntFromUser(allocator: Allocator) !u32 {
    const stdin = std.io.getStdIn().reader();
    const number_slice: []u8 = try stdin.readUntilDelimiterAlloc(allocator, '\n', 100);

    const number: u32 = try std.fmt.parseInt(u32, number_slice, 10);
    return number;
}
