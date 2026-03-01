const std = @import("std");
const posix = std.posix;

pub fn main() !void {
    const address = std.net.Address.parseIp("127.0.0.1", 8080) catch |err| {
        std.debug.print("Failed to parse address: {}\n", .{err});
        return err;
    };

    const domain = posix.AF.INET;
    const socket_type = posix.SOCK.STREAM;
    const protocol = posix.IPPROTO.TCP;
    const socket = posix.socket(domain, socket_type, protocol) catch |err| {
        std.debug.print("Failed to create socket: {}\n", .{err});
        return err;
    };
    defer posix.close(socket);

    posix.connect(socket, &address.any, address.getOsSockLen()) catch |err| {
        std.debug.print("Failed to connect to server: {}\n", .{err});
        return err;
    };

    std.debug.print("Connected to server at {f}\n", .{address});

    var stdin_buf: [1024]u8 = undefined;
    var stdin = std.fs.File.stdin().reader(&stdin_buf);

    var line_buffer: [1024]u8 = undefined;
    var w: std.Io.Writer = .fixed(&line_buffer);

    std.debug.print("What is it that you wanna say?\n", .{});
    const bytes_read = stdin.interface.streamDelimiterLimit(&w, '\n', .unlimited) catch |err| {
        std.debug.print("Failed to read from stdin: {}\n", .{err});
        return err;
    };

    const msg: []const u8 = line_buffer[0..bytes_read];
    const bytes_send = posix.send(socket, msg, 0) catch |err| {
        std.debug.print("Failed to send message: {}\n", .{err});
        return err;
    };

    std.debug.print("Sent {d} bytes\n", .{bytes_send});
}
