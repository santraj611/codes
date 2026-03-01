const std = @import("std");

pub fn main() !void {
    // the smallest space a variable can take is 1 byte

    // there are 6 bitwise operators
    // &, |, ^, ~, <<, >>
    // the best to describe these operators is via truth tables

    const seven = 0b0111;
    const six = 0b0110;
    // now if we take the and (&) operator
    // 0111 & 0110 = 0110
    std.debug.print("seven & six = {b:0>8}\n", .{seven & six});

    const readPermisson: u8 = 4;
    // const writePermisson: u8 = 2;
    // const executePermission: u8 = 1;

    const userPermission: u8 = 6;

    if (userPermission & readPermisson == readPermisson) {
        std.debug.print("Can Read\n", .{});
    } else {
        std.debug.print("Cannot Read\n", .{});
    }

    std.debug.print("{}\n", .{userPermission & readPermisson});

    // or (|) operator
    const five: u8 = 0b0101;
    std.debug.print("five | six = {b:0>8}\n", .{five | six});

    // xor (^) operator
    // let's look at value five (0101) and six (0110) again
    // 0101 ^ 0110 = 0011 which is 3 in binary
    std.debug.print("five ^ six = {b:0>8}\n", .{five ^ six});

    // not (~) operator
    // ~five = 1010 which is 10 in decimal
    // actually this is not how it works
    // five is 8bit number so its binary is 0000 0101
    // and ~five is 1111 1010
    std.debug.print("~5 = {b:0>8} = {d}\n", .{ ~five, ~five }); // 250

    // left shift (<<) and right shift (>>) operators
    std.debug.print("five << 1 = {b:0>8}\n", .{five << 4});
    std.debug.print("five >> 1 = {b:0>8}\n", .{five >> 4});

    // two's complement
    const x: i32 = -43;
    const y: u32 = @bitCast(x);
    std.debug.print("x = {d}\n", .{x});
    std.debug.print("y = {d}\n", .{y});
}
