const std = @import("std");

pub fn main() !void {
    var stdout = std.fs.File.stdout().writer(&.{});
    // try stdout.interface.print("I hope i get this job\n", .{});

    var file = try std.fs.cwd().openFile("messages.txt", .{ .mode = .read_only });
    defer file.close();

    // first read entire file at once
    // var buffer: [1024]u8 = undefined;
    // const bytes_read = file.readAll(&buffer);
    // try stdout.interface.print("{s}\n", .{buffer[0..bytes_read]});

    // second only read 8 bytes at a time
    var reader = file.reader(&.{});

    // read from top
    const end_position: u64 = try file.getEndPos();
    var start_position: u64 = 0;
    try reader.seekTo(start_position);
    while (true) {
        var buffer: [8]u8 = undefined;
        const bytes_read = reader.read(&buffer) catch |err| switch (err) {
            error.EndOfStream => {
                try stdout.interface.print("EOF!\n", .{});
                break;
            },
            else => {
                std.debug.print("Failed to read the File!\n", .{});
                return;
            },
        };
        try stdout.interface.print("bytes_read: {d}\n {s}\n", .{ bytes_read, buffer[0..bytes_read] });
        start_position += @intCast(bytes_read);

        if (start_position > end_position) {
            break;
        }
    }
}
