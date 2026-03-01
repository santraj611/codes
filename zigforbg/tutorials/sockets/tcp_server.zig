const std = @import("std");

pub fn main() !void {
    // Parse the listening address (IPv4, localhost:8080)
    const address = try std.net.Address.parseIp("127.0.0.1", 8080);

    // Initialize the listener with address reuse enabled (to avoid "address in use" errors on restarts)
    var listener = try address.listen(.{
        .reuse_address = true,
    });
    defer listener.deinit();

    std.debug.print("Server listening on {f}\n", .{address});

    // Loop to accept and handle connections
    while (true) {
        const connection = try listener.accept();
        defer connection.stream.close();

        std.debug.print("Accepted connection from {f}\n", .{connection.address});

        // Buffer for reading client data
        var buf: [1024]u8 = undefined;

        // Read data from the client
        const bytes_read = connection.stream.read(&buf) catch |err| {
            std.debug.print("Error reading from client: {}\n", .{err});
            continue;
        };

        if (bytes_read == 0) {
            std.debug.print("Client closed connection\n", .{});
            continue;
        }

        std.debug.print("Received: {s}\n", .{buf[0..bytes_read]});

        // Echo the data back to the client
        connection.stream.writeAll(buf[0..bytes_read]) catch |err| {
            std.debug.print("Error writing to client: {}\n", .{err});
        };
    }
}
