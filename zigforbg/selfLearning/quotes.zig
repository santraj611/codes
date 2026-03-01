const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    // create a http client
    var client = std.http.Client{ .allocator = alloc };
    defer client.deinit();

    const buffer = alloc.alloc(u8, 4096) catch {
        std.debug.print("Out of memory\n", .{});
        return;
    };
    defer alloc.free(buffer);

    const uri = std.Uri.parse("https://ziglang.org/documentation/0.12.0/std/#std.http.Client") catch |err| switch (err) {
        std.Uri.ParseError.InvalidFormat => {
            std.debug.print("Invalid format\n", .{});
            return;
        },
        std.Uri.ParseError.InvalidPort => {
            std.debug.print("Invalid Port\n", .{});
            return;
        },
        std.Uri.ParseError.UnexpectedCharacter => {
            std.debug.print("Unexpected Character\n", .{});
            return;
        },
};
    var req = try client.open(.GET, uri, .{.server_header_buffer = buffer});
    defer req.deinit();

    try req.send();
    try req.finish();

    try req.wait();

    const statusCode = req.response.status;
    if (statusCode == .ok) {
        std.debug.print("Connected\n", .{});
    } else {
        std.debug.print("Failed to connect\n", .{});
        return;
    }

    std.debug.print("---------------------------------------\n", .{});

    var iter = req.response.iterateHeaders();

    while (iter.next()) |header| {
        std.debug.print("Name:{s}, Value:{s}\n", .{ header.name, header.value });
    }

    std.debug.print("---------------------------------------\n", .{});

    try std.testing.expectEqual(req.response.status, .ok);

    var reqReader = req.reader();
    const body = try reqReader.readAllAlloc(alloc, 1024 * 1024 * 4);
    defer alloc.free(body);

    std.debug.print("Body:\n{s}\n", .{body});
}
