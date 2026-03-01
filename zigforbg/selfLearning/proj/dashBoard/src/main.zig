const std = @import("std");
// const dashBoard = @import("dashBoard");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("dashBoard running at http://localhost:8080\n", .{});

    const buff: []u8 = allocator.alloc(u8, 1024) catch unreachable;

    // server takes pointer to reader and writer
    // var server = std.http.Server.init(allocator, .{ .reuse_address = true });
    var io_reader = std.Io.Reader{
        .buffer = buff,
    };
    var io_writer = std.Io.Writer{};
    var server = std.http.Server.init(&io_reader, &io_writer);
    defer server.deinit();

    try server.listen(try std.net.Address.parseIp("127.0.0.1", 8080));
    std.debug.print("dashBoard running at http://localhost:8080\n", .{});

    while (true) {
        var response = try server.accept(.{ .allocator = allocator });
        defer response.deinit();

        var buffer: [1024]u8 = undefined;
        const request_data = try response.reader().readUntilDelimiterOrEof(&buffer, '\n') orelse continue;

        if (std.mem.startsWith(u8, request_data, "GET / ")) {
            const body = "<h1>Welcome to dashBoard!</h1><p>Built with Zig 0.16.</p>";
            try response.writer().print(
                "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: {d}\r\n\r\n{s}",
                .{ body.len, body },
            );
        } else if (std.mem.startsWith(u8, request_data, "GET /api ")) {
            const body = "{\"message\": \"dashBoard API\", \"version\": \"0.16\"}";
            try response.writer().print(
                "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\nContent-Length: {d}\r\n\r\n{s}",
                .{ body.len, body },
            );
        } else {
            try response.writer().writeAll("HTTP/1.1 404 Not Found\r\n\r\n");
        }
    }
}
