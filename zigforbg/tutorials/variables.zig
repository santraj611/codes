const std = @import("std");

pub fn main() void {
    const x: u8 = 4; // constant
    // x += 1; // can not change a constant

    var y: i32 = 1233; // variables can change
    y += 32;

    // initialize vairables with undefined keyword
    var z: u16 = undefined;
    z = 15;

    std.debug.print("x: {d}, y: {d}, z: {d}", .{ x, y, z });
}
