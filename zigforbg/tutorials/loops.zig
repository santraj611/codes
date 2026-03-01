const std = @import("std");

pub fn main() !void {
    var x = [_]u8{ 1, 2, 3, 4 };

    printArr(&x);

    for (&x) |*byte| {
        byte.* *= 2;
    }

    printArr(&x);
}

fn printArr(arr: []u8) void {
    std.debug.print("val ", .{});
    for (arr) |val| {
        std.debug.print("{d} ", .{val});
    }
    std.debug.print("\n", .{});
}
