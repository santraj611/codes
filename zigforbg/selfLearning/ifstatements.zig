const Print = @import("std").debug.print;

pub fn main() void {
    const number: u8 = 30;
    const should_multiply: bool = true;

    // Note: if condition in `if` block passes `else if` and `else` block will be skiped
    if (number == 10 and should_multiply == false) {
        Print("Number: {}\n", .{number});
    } else if (number == 20 or should_multiply == false) {
        Print("Something is happening\n", .{});
    } else if (number <= 50 and should_multiply == true) {
        Print("Number: {}\n", .{ number });
    } else {
        Print("Shut up!\n", .{});
    }
}
