const std = @import("std");
const testing = std.testing;

fn fec(n: u64) u64 {
    if (n == 0 or n == 1) return 1;
    const fectorial: u64 = n * fec(n - 1);
    return fectorial;
}

test "fectorials" {
    try testing.expectEqual(fec(5), 120);
    try testing.expectEqual(fec(6), 720);
}
