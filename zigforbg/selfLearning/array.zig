const std = @import("std");
const ArrayList = std.ArrayList;
const ArenaAllocator = std.heap.ArenaAllocator;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    var arena = ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // Arraylist
    var list = ArrayList(u8).init(allocator);
    defer list.deinit();
    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(" World!");

    try stdout.print("{s}\n", .{list.items}); // Hello World!

    // Another List
    var X = ArrayList(u8).init(allocator);
    defer X.deinit();
    try stdout.print("capacity: {}\n", .{X.capacity});

    var arr = [4]u8{1, 2, 3, 4};
    try X.appendSlice(arr[0..]);
    try stdout.print("{d}\n", .{X.items}); // { 1, 2, 3, 4 }
    try stdout.print("capacity: {}\n", .{X.capacity});

    arr = [4]u8{2, 3, 4, 5};
    try X.appendSlice(arr[0..]);
    try stdout.print("{d}\n", .{X.items}); // { 1, 2, 3, 4, 2, 3, 4, 5 }
    try stdout.print("capacity: {}\n", .{X.capacity});

    for (X.items) |i| {
        //  1, 2, 3, 4, 2, 3, 4, 5 
        try stdout.print("{} ", .{i});
    }
    try stdout.print("\n", .{});

    X.items[0] = 9;
    try stdout.print("First: {}\n", .{X.items[0]});
    try stdout.print("Second: {}\n", .{X.items[1]});
    try stdout.print("Last: {}\n", .{X.items[X.items.len - 1]});
    // try stdout.print("Last: {}\n", .{X.items[X.items.len]}); // This give error index out of rang

    for (X.items) |*byte| {
        byte.* *= 2;
    }
    try stdout.print("{d}\n", .{X.items}); // { 18, 4, 6, 8, 4, 6, 8, 10 }
    
    std.debug.print("Type Of X: {}\n", .{@TypeOf(X)});
}
