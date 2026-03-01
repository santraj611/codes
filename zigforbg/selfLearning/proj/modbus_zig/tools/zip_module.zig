const std = @import("std");
const fs = std.fs;
const File = std.fs.File;
const Dir = std.fs.Dir;

pub fn main() !void {
    // var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // defer _ = gpa.deinit();
    // const alloc = gpa.allocator();

    // const rel_path: []const u8 = "demo";
    // try find(alloc, rel_path);

    // const full_path: []const u8 = "/home/cid/codes/zigforbg/selfLearning/proj/modbus_zig/demo";
    // try find(alloc, full_path);

    try lookUp(std.fs.cwd(), "demo");

    var buf: [std.fs.max_path_bytes]u8 = undefined;
    const root_path = try std.fs.cwd().realpath(".", &buf);
    try findPath(root_path, std.fs.cwd(), ".");
}

// pub const ZipArchive = struct {
//     exclude_list: []const []const u8 = &.{ ".svn", ".pyc", "build", "tools", "release", ".egg-info", "dist", ".externalTool", ".settings", ".hg" },

// pub fn zip_it(self: *ZipArchive, dir_name: []const u8, files: []File) void {
//     const dir_name_prefix: []const u8 = dir_name ++ "/*";
// }

// pub fn run(self: *ZipArchive, folder: Dir, name: []const u8) void {}
// };

//// returns a possibly empty list of path names
//// that match *pathname*, which must a string containing
//// a path specification.
//// *pathname* can be either absolute or relative.
// fn glob(pathname: []const u8) ?[]const []const u8 {
//     // check if path is an absolute path
//     const is_absolute = std.fs.path.isAbsolute(pathname);
//     if (is_absolute) {
//         // do something with it
//         const dir: Dir = try std.fs.openDirAbsolute(pathname, .{ .iterate = true, .access_sub_paths = true, .no_follow = true });
//         defer dir.close();
//
//         // check if dir is empty
//         var it = dir.iterate();
//         if (it.next() == null) {
//             return null;
//         }
//     }
//
//     // else it's relative
// }

// this currently list all files and subdirectories in current pathname
// but does not looks inside of the subdirectories
// fn find(allocator: std.mem.Allocator, path: []const u8) !void {
//     var full_path: []const u8 = undefined;
//
//     // if it's a releative path, make it absolute
//     const is_absolute = std.fs.path.isAbsolute(path);
//     if (is_absolute) {
//         full_path = path;
//     } else {
//         const cwd: []const u8 = std.fs.cwd().realpathAlloc(allocator, ".") catch |err| {
//             std.debug.print("Failed to get current working directory", .{});
//             return err;
//         };
//         defer allocator.free(cwd);
//         full_path = std.fs.path.join(allocator, &.{ cwd, path }) catch |err| {
//             std.debug.print("Failed to join path: {s}", .{path});
//             return err;
//         };
//         defer allocator.free(full_path);
//     }
//
//     std.debug.print("full_path: {s}\n", .{full_path});

// var dir: Dir = std.fs.cwd().openDir(path, .{
//     .iterate = true,
//     .access_sub_paths = true,
//     .no_follow = true,
// }) catch {
//     std.log.err("Failed to open dir: {s}", .{path});
//     std.process.exit(1);
// };
// defer dir.close();
//
// // std.debug.print("Files/Dirs in {s}:\n", .{path});
//
// var it = dir.iterate();
//
// while (try it.next()) |entry| {
//     // check if entry is a file or directory
//     switch (entry.kind) {
//         .directory => {
//             std.debug.print("Directory: {s}\n", .{entry.name});
//             // recursively call find() for each subdirectory
//             const sub_path: []const u8 = std.fs.path.join(allocator, &.{ path, entry.name }) catch |err| {
//                 std.debug.print("Failed to join path: {s}", .{path});
//                 return err;
//             };
//             defer allocator.free(sub_path);
//             // very bad idea, but who cares?
//             try find(allocator, sub_path);
//         },
//         .file => {
//             std.debug.print("File: {s}\n", .{entry.name});
//         },
//         .sym_link => {
//             std.debug.print("Symbolic link: {s}\n", .{entry.name});
//         },
//         else => {
//             std.debug.print("Other: {s}\n", .{entry.name});
//         },
//     }
// } else {
//     std.log.err("Nothing more to iterate in: {s}", .{path});
//     return;
// }
// }

fn lookUp(parent: std.fs.Dir, sub_path: []const u8) !void {
    var dir = try parent.openDir(sub_path, .{
        .iterate = true,
        .access_sub_paths = true,
        .no_follow = true,
    });
    defer dir.close();
    var it = dir.iterate();
    while (try it.next()) |entry| {
        std.debug.print("entry: {s}: {s}\n", .{ @tagName(entry.kind), entry.name });
        switch (entry.kind) {
            .directory => try lookUp(dir, entry.name),
            else => {},
        }
    }
}

fn findPath(root_path: []const u8, parent: std.fs.Dir, sub_path: []const u8) !void {
    var dir = try parent.openDir(sub_path, .{
        .iterate = true,
        .access_sub_paths = true,
        .no_follow = true,
    });
    defer dir.close();
    var buf: [std.fs.max_path_bytes]u8 = undefined;
    var it = dir.iterate();
    while (try it.next()) |entry| {
        const path = try dir.realpath(entry.name, &buf);
        const relative = if (std.mem.startsWith(u8, path, root_path)) path[root_path.len + 1 ..] else path;
        std.debug.print("{s}: {s}\n", .{ @tagName(entry.kind), relative });
        switch (entry.kind) {
            .file => {
                const s = try dir.statFile(entry.name);
                _ = s;
            },
            .directory => try findPath(root_path, dir, entry.name),
            else => {},
        }
    }
}
