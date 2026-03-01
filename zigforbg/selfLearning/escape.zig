const std = @import("std");

pub fn main() !void {
    // Carriage return "\r"
    // moves cursor to beginning
    // and when new text is written it replace the old text
    std.debug.print("something\r\nanything", .{}); // something
                                                   // anything
    std.debug.print("\n", .{});

    // Newline "\n"
    std.debug.print("something\nanything", .{}); // anything
    std.debug.print("\n", .{});
}
