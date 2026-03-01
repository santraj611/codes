const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().createFile("nothing_file.txt", .{ .read = true });
    defer file.close();

    // writing to file
    try file.writeAll("Hello Kids\n");
    _ = try file.write("Wellcome to my world");

    // reading from nothing_file
    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    std.debug.print("{s}", .{buffer});
    std.debug.print("\n----------------------------------\n", .{});
    std.debug.print("{}", .{bytes_read});
}
