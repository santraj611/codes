const std = @import("std");

pub fn main() !void {
    var nums: [100]u8 = undefined;

    // some array  magic
    for (0..nums.len) |i| {
        nums[i] = @intCast(i);
        if (i > 34) nums[i] += 8;
        if (i > 66) nums[i] += 16;
    }
    std.debug.print("nums: ", .{});
    for (nums) |num| std.debug.print("{d} ", .{num});
    std.debug.print("\n", .{});

    // binary search works only on sorted array
    const target: u8 = 94;
    const index = binarySearch(u8, &nums, target) catch |err| {
        std.debug.print("target is not in the array: {any}\n", .{err});
        return;
    };
    std.debug.print("Found {d} at index {d}\n", .{ target, index });
    std.debug.print("Proof: nums[{d}] = {d}\n", .{ index, nums[index] });
}

fn binarySearch(comptime T: type, nums: []const T, target: T) !usize {
    // bounds of array
    var start: usize = 0;
    var end: usize = nums.len;

    while (start < end) {
        const middle: usize = (end + start) / 2; // start from middle

        // check if we found the target
        if (target == nums[middle]) return middle;
        std.debug.print("nums[middle]: {d}, target: {d}\n", .{ nums[middle], target });

        // check if the target is on right or left side
        if (target <= nums[middle]) { // it's on the left side
            end = middle;
        }
        if (target >= nums[middle]) { // it's on the right side
            start = middle + 1;
        }
    }
    return error.NotFound;
}
