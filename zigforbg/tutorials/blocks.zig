const std = @import("std");

pub fn main() void {
    var y: u8 = 10;
    const x: u8 = sqr: {
        const t: u8 = y;
        y *= y;
        break :sqr t;
    };

    std.debug.print("\nx: {d}", .{x});
    std.debug.print("\ny: {d}", .{y});
}
