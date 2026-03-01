const std = @import("std");

pub fn main() void {
    const arr: [3]u8 = [3]u8{ 5, 6, 7 };
    const s: []const u8 = &arr; // to slice, It is also *[3]u8
                                // but we are converting it to a slice
    const p: [*]const u8 = &arr; // to many-item pointer

    std.debug.print("s {d}\n", .{s});
    std.debug.print("p {any}\n", .{p});

    std.debug.print("array: ", .{});
    for (arr) |value| {
        std.debug.print("{d} ", .{value});
    }
    std.debug.print("\ns: {}", .{@TypeOf(s)});
    // std.debug.print("\np: {s}", .{p});
    std.debug.print("\n", .{});

    // multiline
    const hello_in_c: []const u8 =
    \\#include <stdio.h>
    \\
    \\int main(int argc, char **argv) {
    \\    printf("Hello, World!");
    \\    return 0;
    \\}
    ;
    std.debug.print("{s}\n", .{hello_in_c});

    for (p) |byte| {
        std.debug.print("{}", .{byte.*});
    }
    std.debug.print("\n", .{});
}
