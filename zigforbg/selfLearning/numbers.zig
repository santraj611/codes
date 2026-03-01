const std = @import("std");
const math = std.math;

pub fn main() void {
    const n1: u32 = 10;
    const n2: u32 = 3;
    const result: u32 = n1 / n2;

    std.debug.print("10 / 3 = {}\n", .{result});

    const max_no_of_cars: i8 = math.maxInt(i8);
    const min_no_of_cars: i8 = math.minInt(i8);

    std.debug.print("Max no of cars: {}\n", .{max_no_of_cars});
    std.debug.print("Min no of cars: {}\n", .{min_no_of_cars});

    std.debug.print("Max no of cars: {x:0>4}\n", .{max_no_of_cars});
    std.debug.print("Min no of cars: {x:0>4}\n", .{min_no_of_cars});

    // a bool and a u1 are the same size
    const is_he_a_human: u1 = 0; // 0 for false, 1 for true
    const is_he_a_robot: u1 = 1;
    std.debug.print("size of human: {}\n", .{@bitSizeOf(u1)});
    std.debug.print("size of human: {}\n", .{@bitSizeOf(bool)});

    std.debug.print("Is he a human: {}\n", .{is_he_a_human == 0});
    std.debug.print("Is he a robot: {}\n", .{is_he_a_robot == 1});
}
