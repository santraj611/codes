const print = @import("std").debug.print;

pub fn main() void {
    const constant: i8 = 5; // signed 8-bit constant
    const variable: u64 = 5000; // unsigned 64-bit variable
    const dumb: usize = 2342;

    // @as performs an explicit type coercion
    const inferred_constant = @as(i32, 5);
    const inferred_variable = @as(u32, 5000);

    print("{}\n", .{@TypeOf(constant)});
    print("{}\n", .{@TypeOf(variable)});
    print("{}\n", .{@TypeOf(dumb)});
    print("{}\n", .{@TypeOf(inferred_constant)});
    print("{}\n", .{@TypeOf(inferred_variable)});

    const n: u32 = 32;
    const nsqr: u32 = square(n);
    print("n is {}, and it's squared is {}\n", .{ n, nsqr });

    print("\n", .{});
    destructuring_to_existing();

    print("\n", .{});
    changing_value_by_referance();
}

fn square(n: u32) u32 {
    return n * n;
}

fn destructuring_to_existing() void {
    var x: u32 = undefined;
    var y: u32 = undefined;
    var z: u32 = undefined;

    const tuple = .{ 1, 2, 3 };

    x, y, z = tuple;

    print("tuple: x = {}, y = {}, z = {}\n", .{x, y, z});

    const array = [_]u32{ 4, 5, 6 };

    x, y, z = array;

    print("array: x = {}, y = {}, z = {}\n", .{x, y, z});

    const vector: @Vector(3, u32) = .{ 7, 8, 9 };

    x, y, z = vector;

    print("vector: x = {}, y = {}, z = {}\n", .{x, y, z});
}

fn changing_value_by_referance() void {
    var age: u8 = 24;

    print("Age : {}\n", .{ age });

    const ptr: *u8 = &age;

    ptr.* += 1; // changing age to 25

    print("Age : {}\n", .{ age });
}
