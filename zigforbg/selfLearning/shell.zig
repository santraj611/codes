const std = @import("std");
const process = std.process;
const Allocator = std.mem.Allocator;
const Term = std.process.Child.Term;

test "executor" {
    const argv = [_][]const u8{ "echo", "Hello", "World!" };
    const exit_code = try executor(&argv, std.testing.allocator);
    try std.testing.expectEqual(exit_code, std.process.Child.Term{ .Exited = 0 });
}

fn executor(argv: []const []const u8, allocator: Allocator) !Term {
    var cmd = process.Child.init(argv, allocator);
    cmd.stdin_behavior = .Inherit; // Inherit the parent's stdin
    try cmd.spawn();
    const exit_code = try cmd.wait(); // Wait for the process to finish

    return exit_code;
}
