const std = @import("std");
const fmt = std.fmt;
const testing = std.testing;

fn convertToInt(number: []const u8) !u32 {
    return try fmt.parseInt(u32, number, 10);
}

fn convertToFloat(number: []const u8) !f32 {
    return try fmt.parseFloat(f32, number);
}

test convertToInt {
    try testing.expectEqual(convertToInt("16"), 16);
    try testing.expectEqual(convertToInt("18"), 18);
    try testing.expectEqual(convertToInt("32"), 32);
}

test convertToFloat {
    try testing.expectEqual(convertToFloat("12.321"), 12.321);
    try testing.expectEqual(convertToFloat("32.00"), 32.00);
    try testing.expectEqual(convertToFloat("32"), 32);
    try testing.expectEqual(convertToFloat("42.23"), 42.23);
}
