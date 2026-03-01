const std = @import("std");
const stdout = std.io.getStdOut().writer();

// A function that accepts a read-only slice of integers.
// It can work with slices derived from arrays of any size.
fn printSliceInfo(label: []const u8, slice: []const i32) !void {
    try stdout.print("Slice '{s}': Length = {}, Pointer = {*}\n", .{ label, slice.len, slice.ptr });
    try stdout.print("  Elements: ", .{});

    // --- Corrected way to iterate slice with index ---
    var i: usize = 0;
    while (i < slice.len) : (i += 1) { // Loop while index 'i' is less than slice length
        const value = slice[i]; // Get the value at the current index
        try stdout.print("{s}{}", .{ if (i > 0) ", " else "", value }); // Print with comma logic
    }
    // --- End of correction ---

    try stdout.print("\n", .{});
}

// A function that modifies data via a mutable slice.
// Note the parameter type is '[]i32' (not const).
fn doubleSliceElements(slice: []i32) void {
    // We iterate by getting a pointer to each element
    for (slice) |*value_ptr| {
        // Dereference the pointer and multiply the value in place
        value_ptr.* *= 2;
    }
}

pub fn main() !void {
    // Define an array - size 6 is known at compile time.
    var numbers = [6]i32{ 10, 20, 30, 40, 50, 60 };
    try stdout.print("Original array address: {*}, Length: {}\n\n", .{ &numbers, numbers.len });

    // Create slices from the array:
    // 'all_items' is a read-only view of the whole array.
    const all_items: []const i32 = numbers[0..];

    // 'middle_part' is a read-only view of elements at index 2, 3, 4.
    const middle_part: []const i32 = numbers[2..5]; // {30, 40, 50}

    // 'first_three_mut' is a *mutable* view of the first 3 elements.
    const first_three_mut: []i32 = numbers[0..3]; // {10, 20, 30}

    // Use our function to print info about these different slices
    try printSliceInfo("all_items", all_items);
    try printSliceInfo("middle_part", middle_part);
    try printSliceInfo("first_three_mut (before)", first_three_mut);
    try stdout.print("\n", .{});

    // Access an element via a slice (index relative to slice start)
    try stdout.print("Element at index 1 of middle_part (value 40): {}\n\n", .{middle_part[1]});
    // Accessing middle_part[3] would panic because the slice length is 3 (indices 0, 1, 2)

    // Modify the underlying array data *through* the mutable slice
    try stdout.print("Doubling elements using 'first_three_mut' slice...\n", .{});
    doubleSliceElements(first_three_mut); // Pass the mutable slice

    // The original array has been changed!
    try stdout.print("Original array 'numbers' after modification: ", .{});
    var i: usize = 0;
    while (i < numbers.len) : (i += 1) {
        const n = numbers[i];
        try stdout.print("{s}{}", .{ if (i > 0) ", " else "", n });
    }
    try stdout.print("\n\n", .{});

    // Let's look at the slices again - they reflect the changes to the underlying array.
    try printSliceInfo("first_three_mut (after)", first_three_mut);
    try printSliceInfo("all_items (after)", all_items); // Even the 'const' slice sees the change
}
