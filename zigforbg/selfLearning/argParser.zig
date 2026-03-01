const std = @import("std");

pub fn main() !void {
    // Get allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // Parse args into string array (error union needs 'try')
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    // Get and print them!
    // std.debug.print("There are {d} args:\n", .{args.len});
    // for(args) |arg| {
    //     std.debug.print("  {s}\n", .{arg});
    // }

    //takes names of people and greet them!
    std.debug.print("Greetings!\n", .{});
    greet(args[1..]); // skiping file name and just passing names
}

/// Greets people
fn greet(names: [][:0]u8) void {
    for (names) |name| {
        std.debug.print("Hello {s}\n", .{name});
    }
}
