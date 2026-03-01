const std = @import("std");
const eql = std.mem.eql;
const Allocator = std.mem.Allocator;

const stdout = std.io.getStdOut().writer();
const stdin = std.io.getStdIn().reader();

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const alloc = gpa.allocator();

pub fn main() !void {
    try stdout.print("Give The Frist Value\n", .{});

    const a: f64 = getFloat(alloc) catch 0;
    // std.debug.print("a: {d}\n", .{a});

    try stdout.print("Give The Second Value\n", .{});
    const b: f64 = getFloat(alloc) catch 0;

    try stdout.print("What Operation Would You Like to Perform On Them\n", .{});
    const operation: []const u8 = try getOperation(alloc);

    // try stdout.print("{d} {s} {d}\n", .{ a, operation, b });

    var result: f64 = 0;

    if (eql(u8, operation, "+")) {
        result = a + b;
    } else if (eql(u8, operation, "-")) {
        result = a - b;
    } else if (eql(u8, operation, "*")) {
        result = a * b;
    } else if (eql(u8, operation, "/")) {
        if (a == 0 or b == 0) {
            std.debug.print("Can not Devide by Zero!\n", .{});
        } else {
            result = a / b;
        }
    } else {
        std.debug.print("Invalid Operation!\n", .{});
    }

    try stdout.print("{d} {s} {d} = {d:.4}\n", .{ a, operation, b, result });
}

fn getFloat(allocator: Allocator) !f64 {
    try stdout.print("Give an number: \n", .{});

    const input: []const u8 = try stdin.readUntilDelimiterAlloc(allocator, '\n', 100);

    const query_float: f64 = try std.fmt.parseFloat(f64, input);

    return query_float;
}

fn getOperation(allocator: Allocator) ![]u8 {
    const input = try stdin.readUntilDelimiterAlloc(allocator, '\n', 20);
    return input;
}
