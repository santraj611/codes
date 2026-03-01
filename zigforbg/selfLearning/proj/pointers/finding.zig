const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // finding the value at a address
    const addr: []u8 = try getAddr(allocator);
    std.debug.print("addr {s}\n", .{addr});

    // convering this slice to hx
    const addr_int: usize = std.fmt.parseInt(usize, addr, 16) catch |err| switch (err) {
        std.fmt.ParseIntError.InvalidCharacter => {
            std.debug.print("Invalid Character, Failed to parse\n", .{});
            return;
        },
        else => {
            std.debug.print("Failed to parse\n", .{});
            return;
        }

    };
    std.debug.print("addr_int {}\n", .{addr_int});

    // cast pointer and dereferencing
    const ptr: *u8 = @ptrFromInt(addr_int);
    const value_at_ptr: u8 = ptr.*;
    std.debug.print("Value at address {p}: {}\n", .{ ptr, value_at_ptr });

}

fn getAddr(allocator: Allocator) ![]u8 {
    const std_in = std.io.getStdIn().reader();
    const user_addr: ?[]u8 = try std_in.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024);
    const addr: []u8 = user_addr orelse unreachable;

    return addr;
}
