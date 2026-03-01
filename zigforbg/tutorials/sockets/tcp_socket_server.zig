const std = @import("std");
const posix = std.posix;

pub fn main() !void {
    // Parse the listening address (IPv4, localhost:8080)
    const address = try std.net.Address.parseIp("127.0.0.1", 8080);

    // make a tcp socket
    const domain = posix.AF.INET;
    const socket_type = posix.SOCK.STREAM;
    const protocol = posix.IPPROTO.TCP;
    const socket = posix.socket(domain, socket_type, protocol) catch |err| {
        std.debug.print("Error creating socket: {}\n", .{err});
        return err;
    };
    defer posix.close(socket);

    // set SO_REUSEADDR to allow quick restarts
    posix.setsockopt(socket, posix.SOL.SOCKET, posix.SO.REUSEADDR, &std.mem.toBytes(@as(c_int, 1))) catch |err| {
        std.debug.print("Error setting SO_REUSEADDR: {}\n", .{err});
        return err;
    };

    // bind the socket to the address
    posix.bind(socket, &address.any, address.getOsSockLen()) catch |err| {
        std.debug.print("Error binding socket: {}\n", .{err});
        return err;
    };

    // listen on the socket
    const options = std.net.Address.ListenOptions{ .reuse_address = true };
    posix.listen(socket, options.kernel_backlog) catch |err| {
        std.debug.print("Error listening on socket: {}\n", .{err});
        return err;
    };

    std.debug.print("Server listening on {f}\n", .{address});

    // make listen stream
    while (true) {
        var client_addr: std.net.Address = undefined;
        var socklen: posix.socklen_t = @sizeOf(@TypeOf(client_addr));
        const conn = posix.accept(socket, &client_addr.any, &socklen, 0) catch |err| {
            std.debug.print("Error accepting connection: {}\n", .{err});
            return err;
        };
        defer posix.close(conn);

        // get client address
        std.debug.print("Accepted connection from {f}\n", .{client_addr});

        // Buffer for reading client data
        var buf: [1024]u8 = undefined;

        // Read data from the client
        const bytes_read = posix.read(conn, buf[0..]) catch |err| {
            std.debug.print("Error reading from client: {}\n", .{err});
            continue;
        };

        std.debug.print("Received {d} bytes from client: {s}\n", .{ bytes_read, buf[0..bytes_read] });
    }
}
