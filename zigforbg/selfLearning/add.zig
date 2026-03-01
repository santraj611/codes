const std = @import("std");

pub fn main() !void {
    var stdout_writer = std.fs.File.stdout().writer(&.{});
    const stdout = &stdout_writer.interface;

    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // const allocator = gpa.allocator();
    //
    // try stdout.print("This Program Adds two numbers\n", .{});
    //
    // try stdout.print("x: ", .{});
    // const x: i32 = try getInt(allocator);
    // try stdout.print("\n", .{});
    //
    // try stdout.print("y: ", .{});
    // const y: i32 = try getInt(allocator);
    // try stdout.print("\n", .{});
    //
    // const sum: i32 = add(x, y);
    //
    // try stdout.print("{} + {} = {}\n", .{ x, y, sum });

    const a: u8 = 117;
    const b: u8 = 30;
    try stdout.print("a: {b:0>7}\nb: {b:0>7}\n", .{ a, b });
    const sum: u8 = subBinary(comptime u8, a, b);
    try stdout.print("{b:0>7} - {b:0>7} = {b:0>7}\n", .{ a, b, sum });
}

// fn add(a: i32, b: i32) i32 {
//     return a + b;
// }

// fn getInt(allocator: std.mem.Allocator) !i32 {
//     const stdin = std.io.getStdIn().reader();
//     const num_slice: ?[]u8 = try stdin.readUntilDelimiterAlloc(allocator, '\n', 100);
//
//     // parsing the int from slice
//     const num: i32 = try std.fmt.parseInt(i32, num_slice.?, 10);
//     return num;
// }

/// this function subtracts binary numbers `a` and `b`
/// this function is still incomplete do not use it.
fn subBinary(comptime T: type, a: T, b: T) T {
    var result: T = undefined;

    // take b's 1's compliment
    const b_comp: T = ~b;

    // then add a + b_comp
    var sum: T = undefined;
    var carry: u1 = undefined;

    // calculate carry?
    sum, carry = @addWithOverflow(a, b_comp);

    // check for carry
    if (carry > 0) {
        result = sum + carry;
    } else {
        result = ~sum;
    }

    // then return result accordingly
    return result;
}
