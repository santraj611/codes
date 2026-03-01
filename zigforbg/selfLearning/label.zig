const std = @import("std");

pub fn main() void {
    const foo = make_five: {
        const five = 1 + 1 + 1 + 1 + 1;
        break :make_five five;
        // return value after break 
    };

    std.debug.print("foo: {}\n", .{foo});
}
