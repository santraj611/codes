const std = @import("std");

pub fn main() !void {
    const name: []const u8 = "ninja";
    const another_name: []const u8 = "Ninja";

    const name_hash: u64 = hash(name);
    const another_name_hash: u64 = hash(another_name);

    std.debug.print("name_hash: {d}\n", .{name_hash});
    std.debug.print("another_name_hash: {d}\n", .{another_name_hash});

    const ninja: []const u8 = "ninja";
    std.debug.print("ninja: {d}\n", .{hash(ninja)});
}

/// Generate Hash for strings
fn hash(slice: []const u8) u64 {
    // Let's see what should i code here
    // I can just hash strings
    const slice_hash = std.hash_map.hashString(slice);
    return slice_hash;
}
