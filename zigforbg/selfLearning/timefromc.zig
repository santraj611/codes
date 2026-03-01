const std = @import("std");
const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("time.h");
});

pub fn main() !void {
    const dt: []const u8 = createTimestamp();
    std.debug.print("DateTime: {s}\n", .{dt});
}

fn createTimestamp() []const u8 {
    var time: c.time_t = undefined;
    _ = c.time(&time);
    const local_time = c.localtime(&time);
    const dt = std.mem.sliceTo(c.asctime(local_time), 0);

    return std.mem.trim(u8, dt, "\r\n");
}
