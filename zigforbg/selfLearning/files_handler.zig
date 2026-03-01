const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const home: ?[]const u8 = std.posix.getenv("HOME");
    const path: []const u8 = "Downloads";
    // const file_name: []const u8 = "foo.txt";

    const full_path = try std.fs.path.join(allocator, &[_][]const u8{ home.?, path });
    std.debug.print("Creating foo.txt at: {s}\n", .{ full_path });

    var downloads = try std.fs.openDirAbsolute(full_path,
        .{
            .access_sub_paths = true,
            .iterate = true 
        });
    try downloads.setAsCwd();
    defer downloads.close();
    const cwd = std.fs.cwd();

    var walker: std.fs.Dir.Walker = try cwd.walk(allocator);
    
    while (try walker.next()) |entry| {
        std.debug.print("File Name: {s}\n", .{entry.basename});
    }

    // var foo = try std.fs.createFileAbsolute(full_path, .{});
    // foo.close();
    //
    // foo = try std.fs.openFileAbsolute(full_path, .{ .mode = .read_write });
    // defer foo.close();
    //
    // const foo_reader = foo.reader();
    // const foo_writer = foo.writer();
    //
    // const bytes: usize = try foo_writer.write("Foo: f(x) = x^2\n");
    // std.debug.print("Total {d} bytes writen to foo\n", .{bytes});
    //
    // try foo.seekTo(0); // trying to read from top
    // const foo_content = try foo_reader.readAllAlloc(allocator, 2048);
    //
    // std.debug.print("{s}\n", .{foo_content});
}
