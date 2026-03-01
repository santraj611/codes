const std = @import("std");
const net = std.net;

// Constants
const PORT: u16 = 1010;
const HOST_ADDRESS: []const u8 = "0.0.0.0";

pub fn main() !void {
    // making a tcp server
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const stdout = std.io.getStdOut().writer();

    std.debug.print("Starting server\n", .{});
    const self_addr = try net.Address.parseIp4(HOST_ADDRESS, PORT); // returns an Address

    var listener = try self_addr.listen(.{ .reuse_address = true }); // returns a server
    defer listener.deinit();
    std.debug.print("Listening on {}\n", .{self_addr});

    const buff: []u8 = try allocator.alloc(u8, 1024);
    defer allocator.free(buff);

    while (true) {
        const conn = try listener.accept(); // returns a connection
        defer conn.stream.close();
        std.debug.print("Accepted connection from: {}\n", .{conn.address});

        // Handle the connection...
        const response_size = try conn.stream.read(buff);
        try stdout.print("FROM: {}\nURL: {s}\nURL SIZE: {d}\n", .{ conn.address, buff[0..response_size], response_size });

        _ = try conn.stream.write("Url Received!\n");
    }

}
