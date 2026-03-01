const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const stdin = std.io.getStdIn().reader();
    std.debug.print("Factorial of what number!\n", .{});
    const number_slice: []u8 = try stdin.readUntilDelimiterAlloc(allocator, '\n', 100);
    const number: u32 = try std.fmt.parseInt(u32, number_slice, 10);

    var product: usize = 1;

    if (number == 0 and number == 1) {
        product = 1;
    } else {
        var i: usize = 1;

        while (i <= number) : (i += 1) {
            product *= i;
        }
    }

    std.debug.print("{d}! = {d}\n", .{ number, product });
}
