const std = @import("std");

pub fn main() !void {
    // addr
    const addr = std.net.Address.initIp4(.{ 127, 0, 0, 1 }, 8080);

    // socket
    const domain = std.posix.AF.INET;
    const socket_type = std.posix.SOCK.DGRAM;
    const protocol = std.posix.IPPROTO.UDP;
    const socket = std.posix.socket(domain, socket_type, protocol) catch |err| {
        std.debug.print("Failed to create socket: {}\n", .{err});
        return err;
    };
    defer std.posix.close(socket);

    // set SO_REUSEADDR to allow quick restarts
    const level: i32 = std.posix.SOL.SOCKET;
    const optname: u32 = std.posix.SO.REUSEADDR;
    const opt: []const u8 = &std.mem.toBytes(@as(c_int, 1));
    std.posix.setsockopt(socket, level, optname, opt) catch |err| {
        std.debug.print("Error setting SO_REUSEADDR: {}\n", .{err});
        return err;
    };

    // bind
    std.posix.bind(socket, &addr.any, addr.getOsSockLen()) catch |err| {
        std.debug.print("Failed to bind socket: {}\n", .{err});
        return err;
    };

    std.debug.print("Listening on {f}\n", .{addr});

    // make receive stream
    while (true) {
        var buf: [1024]u8 = undefined;
        const bytes_read = std.posix.recv(socket, buf[0..], 0) catch |err| {
            std.debug.print("Error reading from client: {}\n", .{err});
            continue;
        };

        std.debug.print("Received {d} bytes from client: {s}\n", .{ bytes_read, buf[0..bytes_read] });
    }
}
