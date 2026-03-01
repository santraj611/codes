const std = @import("std");
const expect = std.testing.expect;
const net = std.net;
const os = std.os.linux;

// test "create a socket" {
//     const socket = try Socket.init("127.0.0.1", 3000);
//     try expect(@TypeOf(socket.socket) == os.socket_t);
// }

pub fn main() !void {
    var socket = try Socket.init("127.0.0.1", 3000);
    try socket.bind();
    try socket.listen();
    _ = try socket.close();
}

const Socket = struct {
    address: std.net.Address,
    socket: os.socket_t,

    fn init(ip: []const u8, port: u16) !Socket {
        const parsed_address = try std.net.Address.parseIp4(ip, port);
        const sock = os.socket(os.AF.INET, os.SOCK.DGRAM, 0);
        errdefer os.close(@intCast(sock));
        return Socket{ .address = parsed_address, .socket = @intCast(sock)};
    }

    fn bind(self: *Socket) !void {
        _ = os.bind(self.socket, &self.address.any, self.address.getOsSockLen());
    }

    fn listen(self: *Socket) !void {
        var buffer: [1024]u8 = undefined; 

        while (true) {
            const sock_len = self.address.getOsSockLen();
            const received_bytes = os.recvfrom(self.socket, buffer[0..], sock_len, 0, null, null);
            std.debug.print("Received {d} bytes: {s}\n", .{ received_bytes, buffer[0..received_bytes] }); 
        }
    }
    
    fn close(self: *Socket) !usize {
        return os.close(self.socket);
    }
};
