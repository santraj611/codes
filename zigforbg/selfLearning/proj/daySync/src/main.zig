const std = @import("std");
const daySync = @import("root.zig");
const os = std.os.linux;
const net = std.net;
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(gpa.deinit() == .ok);
    const allocator = gpa.allocator();

    const unixEpoch = try daySync.syncTime(allocator);
    std.debug.print("Fetched NTP time: {d} (UNIX epoch)\n", .{unixEpoch});

    // Example: setting system clock (needs root)
    var tv = os.timeval{ .tv_sec = unixEpoch, .tv_usec = 0 };
    if (os.settimeofday(&tv, null) != 0) {
        std.debug.print("Failed to set time: errno={}\n", .{os.errno(-1)});
    } else {
        std.debug.print("System time set successfully!\n", .{});
    }
}
