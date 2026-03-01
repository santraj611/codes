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

    // connect
    // std.posix.connect(socket, &addr.any, addr.getOsSockLen()) catch |err| {
    //     std.debug.print("Failed to connect to server: {}\n", .{err});
    //     return err;
    // };

    // read input
    var stdin_buf: [1024]u8 = undefined;
    var stdin = std.fs.File.stdin().reader(&stdin_buf);

    var line_buffer: [1024]u8 = undefined;
    var w: std.Io.Writer = .fixed(&line_buffer);

    std.debug.print("What is it that you wanna say?\n", .{});
    const bytes_read = stdin.interface.streamDelimiterLimit(&w, '\n', .unlimited) catch |err| {
        std.debug.print("Failed to read from stdin: {}\n", .{err});
        return err;
    };

    // send msg
    const msg: []const u8 = line_buffer[0..bytes_read];
    const bytes_send = std.posix.sendto(socket, msg, 0, &addr.any, addr.getOsSockLen()) catch |err| {
        // const bytes_send = std.posix.send(socket, msg, 0) catch |err| {
        std.debug.print("Failed to send message: {}\n", .{err});
        return err;
    };

    std.debug.print("Sent {d} bytes\n", .{bytes_send});
}
