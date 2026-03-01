const std = @import("std");
const Allocator = std.mem.Allocator;

fn Stack(
    comptime T: type
) type {
    return struct {
        const Self = @This();

        allocator: Allocator,
        stack: std.ArrayList(T) = .empty,

        pub fn add(self: *Self, val: T) !void {
            try self.stack.append(self.allocator, val);
        }
        pub fn pop(self: *Self) void {
            _ = self.stack.pop() orelse return;
        }
        pub fn destroy(self: *Self) void {
            self.stack.deinit(self.allocator);
        }
        pub fn print(self: *Self) void {
            for (self.stack.items) |item| {
                std.debug.print("{} ", .{item});
            }
            std.debug.print("\n", .{});
        }
    };
}


pub fn main() !void {
    const gpa = std.heap.smp_allocator;
    const stackIsize = Stack(isize);
    var stack: stackIsize = .{ .allocator = gpa };
    defer stack.destroy();

    try stack.add(20);
    try stack.add(22);
    try stack.add(-213);
    try stack.add(24);
    try stack.add(13);
    try stack.add(-23);

    stack.pop();
    stack.pop();
    stack.pop();

    stack.print();
}
