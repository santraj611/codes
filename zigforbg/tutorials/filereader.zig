const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const file = std.fs.cwd().openFile("foo.txt", .{}) catch |err| switch (err) {
        std.fs.File.OpenError.AccessDenied => {
            std.debug.print("You do not have permission to access this file\n", .{});
            std.process.exit(1);
        },
        std.fs.File.OpenError.FileNotFound => {
            std.debug.print("Could not found file\n", .{});
            std.process.exit(1);
        },
        else => {
            std.debug.print("Failed to openFile\n", .{});
            std.process.exit(1);
        },
    };

    defer file.close();

    const buffer = allocator.alloc(u8, 1024) catch |err| {
        std.debug.print("You don't have enough memory\n{}", .{err});
        return;
    };

    defer allocator.free(buffer);

    const read_bytes = try file.read(buffer);

    std.debug.print("Read Bytes: {}\n", .{read_bytes});
    std.debug.print("Buffer: {s}\n", .{buffer}); // printing entire buffer is bad idea
    std.debug.print("size of buffer: {}\n", .{buffer.len});

    const msg: []const u8 = buffer[0..read_bytes];
    std.debug.print("Msg: {s}\n", .{msg});
    std.debug.print("size of msg: {}\n", .{msg.len});
}
