const std = @import("std");
const os = std.os.linux;
const net = std.net;
const Allocator = std.mem.Allocator;

pub fn syncTime(allocator: Allocator) !i64 {
    // 1. Resolve NTP server address (IPv4 or IPv6)
    const addr = try net.Address.parseIp("time.google.com", 123);
    // const addr = try net.getAddress(allocator, "time.google.com", 123);
    defer allocator.free(addr);

    // 2. Create UDP socket
    const sock_fd = os.socket(os.AF.INET, os.SOCK.DGRAM, os.IPPROTO.UDP);
    if (sock_fd < 0) return os.errno(sock_fd);
    defer os.close(sock_fd) catch {};

    // 3. Build and send NTP request packet
    var pkt: [48]u8 = undefined;
    @memset(&pkt, 0);
    pkt[0] = 0x1B; // LI=0, VN=3, Mode=3
    const sent = os.sendto(
        @intCast(sock_fd),
        &pkt,
        48,
        0,
        &addr.any,
        addr.getOsSockLen(),
    );
    if (sent < 0) return os.errno(sent);

    // 4. Receive response
    var resp: [48]u8 = undefined;
    var from_addr: [128]u8 = undefined; // enough space
    var addr_len: os.socklen_t = @sizeOf(from_addr);
    const recvd = try os.recvfrom(
        sock_fd,
        &resp,
        resp.len,
        0,
        @ptrCast(&from_addr),
        &addr_len,
    );
    if (recvd < 0) return os.errno(recvd);
    if (recvd != 48) return error.InvalidResponse;

    // 5. Parse transmit timestamp (bytes 40..43 seconds, 44..47 fraction)
    const secs1900 = (@as(u32, resp[40]) << 24)
                   | (@as(u32, resp[41]) << 16)
                   | (@as(u32, resp[42]) << 8)
                   | @as(u32, resp[43]);
    // const frac = (@as(u32, resp[44]) << 24)
    //            | (@as(u32, resp[45]) << 16)
    //            | (@as(u32, resp[46]) << 8)
    //            | @as(u32, resp[47]);

    // 6. Convert NTP epoch → Unix epoch
    const unixSecs: i64 = @as(i64, @intCast(secs1900)) - 2208988800;
    return unixSecs;
}

