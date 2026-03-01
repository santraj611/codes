const std = @import("std");
const parser = @import("parser.zig");

pub fn main() !void {
    const addr = std.net.Address.initIp4(.{ 127, 0, 0, 1 }, 8080);

    var listener = try addr.listen(.{ .reuse_address = true });

    std.debug.print("Listening on {f}\n", .{addr});
    while (true) {
        const conn = try listener.accept();
        defer conn.stream.close();
        std.debug.print("Got connection from {f}\n", .{conn.address});

        var buffer: [1024]u8 = undefined;
        const len = try conn.stream.read(&buffer);
        // std.debug.print("Read {d} bytes: {s}\n", .{ len, buffer[0..len] });

        const http_response: []const u8 = parser.parser(buffer[0..len]);

        try conn.stream.writeAll(http_response);
    }
}
