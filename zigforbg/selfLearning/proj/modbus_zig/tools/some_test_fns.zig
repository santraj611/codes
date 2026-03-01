const std = @import("std");

pub fn main() !void {
    var buf: [std.fs.max_path_bytes]u8 = undefined;
    const root_path = try std.fs.cwd().realpath(".", &buf);
    var path_buf: [std.fs.max_path_bytes]u8 = undefined;
    try find(root_path, &path_buf, 0, std.fs.cwd(), ".");
}

fn find(root_path: []const u8, path_buf: []u8, path_buf_offset: usize, parent: std.fs.Dir, sub_path: []const u8) !void {
    var dir = try parent.openDir(sub_path, .{
        .iterate = true,
        .access_sub_paths = true,
        .no_follow = true,
    });
    defer dir.close();

    var it = dir.iterate();
    while (try it.next()) |entry| {
        @memcpy(path_buf[path_buf_offset .. path_buf_offset + entry.name.len], entry.name);
        path_buf[path_buf_offset + entry.name.len] = '/';
        std.debug.print("{s}: {s}\n", .{ @tagName(entry.kind), path_buf[0 .. path_buf_offset + entry.name.len] });
        switch (entry.kind) {
            .file => {
                const s = try dir.statFile(entry.name);
                _ = s;
            },
            .directory => try find(root_path, path_buf, path_buf_offset + entry.name.len + 1, dir, entry.name),
            else => {},
        }
    }
}

