const print = @import("std").debug.print;

pub fn main() void {
    for (1..20) |n| {
        if (n % 3 == 0 and n % 5 == 0) {
            print("FizzBuzz\n", .{});
        } else if (n % 3 == 0) {
            print("Fizz\n", .{});
        } else if (n % 5 == 0) {
            print("Buzz\n", .{});
        } else {
            print("{d}\n", .{n});
        }
    }
}
