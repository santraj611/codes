const Print = @import("std").debug.print;

pub fn main() void {
    const a_char: u8 = 'a';

    Print("a_char: {}\n", .{a_char});
    Print("a_char: {u}\n", .{a_char});
    Print("a_char: {c}\n", .{a_char});

    // They can be numbers or u8 chars
    const char_array: [5]u8 = [5]u8{ 'H', 'e', 'l', 'l', 'o' };
    const char_slice: []const u8 = "Hello";
    const inferred_slice = "Hello"; // The line above and this line are same.
    const inferred_array_slice = char_array[0..]; // The line above and this line are same
    const char_slice2: []const u8 = char_array[0..4];
    var numbers: [5]u8 = [5]u8{ 1, 2, 3, 4, 5 };
    const numbers_slice: []u8 = numbers[0..];

    for (numbers_slice) |*byte| {
        byte.* *= 2;
    }
    Print("numbers: {d}\n", .{numbers_slice});

    Print("char_array: ", .{});
    for (char_array) |char| {
        Print("{u}", .{char});
    }
    Print("\n", .{});

    Print("char_slice: {s}\n", .{char_slice});
    Print("inferred_slice: {s}\n", .{inferred_slice});
    Print("inferred_array_slice: {s}\n", .{inferred_array_slice});
    Print("char_slice2: {s}\n", .{char_slice2});
}
