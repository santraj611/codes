const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var value: i32 = 42;

    // Declare a pointer variable 'ptr'.
    // Its type is '*i32' (pointer to a 32-bit signed integer).
    // Initialize it with the memory address of 'value' using '&'.
    const ptr: *i32 = &value;

    try stdout.print(" 1. Original value: {}\n", .{value});

    // Access the value stored AT the address held by 'ptr'.
    // This is called 'dereferencing' the pointer using '.*'.
    try stdout.print(" 2. Value via pointer (ptr.*): {}\n", .{ptr.*});

    // You can modify the original variable's value THROUGH the pointer.
    ptr.* = 99; // Change the value at the memory location pointed to by 'ptr'.

    // Check the original variable again - it has changed!
    try stdout.print(" 3. Value after modification via pointer: {}\n", .{value});
    try stdout.print(" 4. Value via pointer after modification: {}\n", .{ptr.*}); // Still points to the same place

    // What does the pointer variable itself contain? An address.
    // Use the '{p}' format specifier to print pointer addresses (usually in hexadecimal).
    try stdout.print(" 5. Memory address stored in ptr: {p}\n", .{ptr});
    try stdout.print(" 6. Memory address of 'value' (&value): {p}\n", .{&value}); // Note: Should be the same address!
}
