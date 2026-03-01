const std = @import("std");

pub fn main() !void {
    const nums: [10]u8 = [10]u8{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    const target: u8 = 8;
    const index = try linearSearch(u8, &nums, target);
    std.debug.print("Found {d} at index {d}\n", .{ target, index });
}

fn linearSearch(comptime T: type, nums: []const T, target: T) !usize {
    for (nums, 0..) |num, i| {
        if (num == target) {
            return i;
        }
    }
    return error.NotFound;
}
