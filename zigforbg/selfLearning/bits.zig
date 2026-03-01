const std = @import("std");

pub fn main() !void {
    var bitmask: u8 = 0b0000_0011;
    var num: u8 = 0b0000_0101;
    std.debug.print("bitmask: {d}\n", .{bitmask});
    std.debug.print("bitmask: {b:0>8}\n", .{bitmask});
    std.debug.print("num: {d}\n", .{num});
    std.debug.print("num: {b:0>8}\n", .{num});

    // setting bits with or operator
    num |= bitmask;
    std.debug.print("num: {d}\n", .{num});
    std.debug.print("num: {b:0>8}\n", .{num});

    // clearning bits with and and not operator
    num &= ~bitmask;
    std.debug.print("num: {d}\n", .{num});
    std.debug.print("num: {b:0>8}\n", .{num});

    // toggling bits with xor operator
    num ^= bitmask;
    std.debug.print("num: {d}\n", .{num});
    std.debug.print("num: {b:0>8}\n", .{num});

    // checking bits
    const is_set = (num & bitmask) != 0;
    std.debug.print("is_set: {}\n", .{is_set});

    // generating bitmasks
    // left shift
    const position = 2;
    bitmask = 1 << position;
    std.debug.print("bitmask: {d}\n", .{bitmask});
    std.debug.print("bitmask: {b:0>8}\n", .{bitmask});

    // range mask
    const start = 2;
    const end = 4;
    bitmask = ((1 << (end - start + 1)) - 1) << start;
    std.debug.print("bitmask: {d}\n", .{bitmask});
    std.debug.print("bitmask: {b:0>8}\n", .{bitmask});

    // combine masks
    bitmask = (1 << 2) | (1 << 4);
    std.debug.print("bitmask: {d}\n", .{bitmask});
    std.debug.print("bitmask: {b:0>8}\n", .{bitmask});
}
