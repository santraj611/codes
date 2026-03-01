const std = @import("std");

pub fn parser(req: []const u8) []const u8 {
    // std.debug.print("{s}\n", .{req});

    // let's read until the first '\r\n'
    var it = std.mem.splitAny(u8, req, "\r\n");
    const main_line = it.first();
    std.debug.print("main_line: {s}\n", .{main_line});

    var it2 = std.mem.splitAny(u8, main_line, " ");
    const method = it2.first();
    const path = it2.next().?;
    // const protocol = it2.next().?;
    // std.debug.print("method: {s}\n", .{method});
    // std.debug.print("path: {s}\n", .{path});
    // std.debug.print("protocol: {s}\n", .{protocol});

    // handle the request
    if (std.mem.eql(u8, method, "GET")) {
        if (std.mem.eql(u8, path, "/")) {
            return 
            \\HTTP/1.1 200 OK
            \\
            \\<!DOCTYPE html>
            \\  <html>
            \\    <head>
            \\      <title>Hello, World!</title>
            \\    </head>
            \\    <body>
            \\      <h1>Hello, World!</h1>
            \\      <p>This is a simple HTTP server.</p>
            \\    </body>
            \\  </html>
            ;
        }

        return 
        \\HTTP/1.1 404 Not Found
        \\
        \\<!DOCTYPE html>
        \\  <html>
        \\    <head>
        \\      <title>404 Not Found</title>
        \\    </head>
        \\    <body>
        \\      <h1>404 Not Found</h1>
        \\      <p>The requested resource was not found on this server.</p>
        \\    </body>
        \\  </html>
        ;
    }

    return 
    \\HTTP/1.1 501 Not Implemented
    \\
    \\<!DOCTYPE html>
    \\  <html>
    \\    <head>
    \\      <title>501 Not Implemented</title>
    \\    </head>
    \\    <body>
    \\      <h1>501 Not Implemented</h1>
    \\      <p>The requested method is not implemented by this server.</p>
    \\    </body>
    \\  </html>
    ;
}
