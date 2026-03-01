const std = @import("std");

pub fn main() !void {
    // Parse the server address (IPv4, localhost:8080)
    const address = try std.net.Address.parseIp("127.0.0.1", 8080);

    // Connect to the server
    var stream = try std.net.tcpConnectToAddress(address);
    defer stream.close();

    std.debug.print("Connected to server at {f}\n", .{address});

    // Message to send
    const message = "Hello from client!\n";

    // Send the message
    try stream.writeAll(message);

    // Buffer for reading the response
    var buf: [1024]u8 = undefined;

    // Read the echoed response
    const bytes_read = try stream.read(&buf);

    if (bytes_read == 0) {
        std.debug.print("Server closed connection\n", .{});
        return;
    }

    std.debug.print("Received from server: {s}\n", .{buf[0..bytes_read]});
}
