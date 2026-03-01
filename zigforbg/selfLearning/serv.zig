const std = @import("std");
const net = std.net;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    std.debug.print("Starting server\n", .{});
    const self_addr = try net.Address.resolveIp("0.0.0.0", 8080);
    var listener = try self_addr.listen(.{ .reuse_address = true });
    defer listener.deinit();
    std.debug.print("Listening on {}\n", .{self_addr});

    const buff: []u8 = try allocator.alloc(u8, 1024);
    defer allocator.free(buff);

    while (listener.accept()) |conn| {
        std.debug.print("Accepted connection from: {}\n", .{conn.address});
        // Handle the connection...

        const response_size = try conn.stream.read(buff);
        std.debug.print("msg_size: {d}\nUser: {s}\n", .{response_size, buff[0..response_size]});

        _ = try conn.stream.write("Hello from server\n");
    }

    // while (true) {
    //     const conn = try listener.accept();
    //     defer conn.stream.close();
    //     std.debug.print("Accepted connection from: {}\n", .{conn.address});
    //     // Handle the connection...
    //
    //     const response_size = try conn.stream.read(buff);
    //     std.debug.print("msg_size: {d}\nUser: {s}\n", .{response_size, buff[0..response_size]});
    //
    //     _ = try conn.stream.write("Hello from server\n");
    // }
}
