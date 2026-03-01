const print = std.debug.print;
const std = @import("std");

pub fn main() void {
    // for (0..100) |i| {
    //     print("fibonacci({}) = {}\n", .{ i, fibonacci(i) });
    // }

    // type info
    const x: f32 = 0.0;
    print("x: {}\n", .{ @typeInfo(f32)} );
    print("x: {s}\n", .{ @typeName(f32)} );
    print("x: {}\n", .{ @TypeOf(x)} );

    print("struct: {}\n", .{ @typeInfo(struct {})} );
}

fn fibonacci(n: usize) u128{
    var a: u128 = 0;
    var b: u128 = 1;

    if (n == 0) return a;
    if (n == 1) return b;

    var i: usize = 2;
    while (i <= n) : (i += 1) {
        const tmp: u128 = a + b;
        a = b;
        b = tmp;
    }

    return b;
}
