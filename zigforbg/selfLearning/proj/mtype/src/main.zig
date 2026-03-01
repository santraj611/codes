const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    // Create an allocator.
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Parse the URI.
    const uri = try std.Uri.parse("https://www.goodreads.com/quotes");

    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();

    const server_header_buffer: []u8 = try allocator.alloc(u8, 1024 * 8);
    defer allocator.free(server_header_buffer);

    // Make the connection to the server.
    var req = try client.open(.GET, uri, .{
        .server_header_buffer = server_header_buffer,
    });
    defer req.deinit();

    try req.send();
    try req.finish();
    try req.wait();

    print("Response status: {d}\n\n", .{req.response.status});

    // Print out the headers
    print("{s}\n", .{req.response.iterateHeaders().bytes});

    // Print out the headers (iterate)
    // var it = req.response.iterateHeaders();
    // while (it.next()) |header| {
    //     print("{s}: {s}\n", .{ header.name, header.value });
    // }

    // Read the entire response body, but only allow it to allocate 1024 * 8 of memory.
    const body = try req.reader().readAllAlloc(allocator, 1024 * 8);
    defer allocator.free(body);

    // Print out the body.
    print("{s}\n", .{body});
