const std = @import("std");
const expect = std.testing.expect;
const builtin = @import("builtin");

test "builtin.is_test" {
    try expect(isATest());
}

fn isATest() bool {
    return builtin.is_test;
}
