const std = @import("std");

pub fn main() !void {
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    if (args.len != 3) {
        std.debug.print("Usage: {s} <pid> <hex_address>\n", .{args[0]});
        return;
    }

    const pid: u32 = try std.fmt.parseInt(u32, args[1], 10);
    const address: usize = try std.fmt.parseInt(usize, args[2], 16);

    var path_buf: [64]u8 = undefined;
    const path = try std.fmt.bufPrint(&path_buf, "/proc/{}/mem", .{pid});
    std.debug.print("path_buf: {s}\n", .{path_buf});
    std.debug.print("path: {s}\n", .{path});


    var file = try std.fs.openFileAbsolute(path, .{ .mode = .read_only });
    defer file.close();

    try file.seekTo(address);
    var buf: [1]u8 = undefined;
    _ = try file.readAll(&buf);
    std.debug.print("Value at address {x}: {}\n", .{ address, buf[0] });
}
