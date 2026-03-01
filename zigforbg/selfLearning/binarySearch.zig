const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Define the array
    const sortedArray = [_]u8{ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' };

    // Create a slice from the array
    const slice = sortedArray[0..];

    // Perform binary search
    const index = try binarySearch(slice, 'd');
    try stdout.print("index: {}\n", .{index});
    try stdout.print("Array[index]: {u}\n", .{sortedArray[index]});
}

// Binary search function using slices
fn binarySearch(array: []const u8, value: u8) !usize {
    var start: usize = 0;
    var end: usize = array.len;

    while (start < end) {
        const mid = start + (end - start) / 2;
        if (array[mid] == value) {
            return mid;
        } else if (array[mid] < value) {
            start = mid + 1;
        } else {
            end = mid;
        }
    }

    return error.ValueNotFound;
}
