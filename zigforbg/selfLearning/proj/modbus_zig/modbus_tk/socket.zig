const std = @import("std");

const Socket = struct {
    address: std.net.Address,
    socket: std.os.linux.socket_t,

    fn init(ip: []const u8, port: u16) !Socket {
        const parsed_address = try std.net.Address.parseIp4(ip, port);
        const sock = try std.os.linux.socket(std.os.AF.INET, std.os.linux.SOCK.STREAM, 0);
        errdefer std.os.linux.close(sock);
        return Socket{ .address = parsed_address, .socket = sock };
    }

    fn bind(self: *Socket) void {
        std.os.linux.bind(self.socket, &self.address.any, self.address.getOsSockLen());
    }

    fn listen(self: *Socket) void {
        var buffer: [1024]u8 = undefined;

        while (true) {
            const received_bytes = std.os.linux.recvfrom(self.socket, buffer[0..], 0, null, null);
            std.debug.print("Received {d} bytes: {s}\n", .{ received_bytes, buffer[0..received_bytes] });
        }
    }

    fn close(self: *Socket) void {
        std.os.linux.close(self.socket);
    }
};
