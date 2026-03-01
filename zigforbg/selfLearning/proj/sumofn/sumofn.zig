const std = @import("std");

pub fn main() !void {
    const number: u8 = 5;
    var sum: usize = 0;

    // with for loop
    // for (0..number + 1) |n| {
    //     sum += n;
    // }

    // with while loop
    var i: usize = 0;
    while (i <= 5) : (i += 1) {
        sum += i;
    }

    std.debug.print("sum up to {d} is {d}\n", .{ number, sum });
}
