const expect = @import("std").testing.expect;

fn increment(comptime T: type, num: *T) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(comptime u8, &x);
    try expect(x == 2);
}

test "comptime pointers" {
    comptime {
        var x: i32 = 1;
        const ptr = &x;
        ptr.* += 1;
        x += 1;
        try expect(ptr.* == 3);
    }
}

test "@intFromPtr and @ptrFromInt" {
    const ptr: *i32 = @ptrFromInt(0xdeadbee0);
    const addr = @intFromPtr(ptr);
    try expect(@TypeOf(addr) == usize);
    try expect(addr == 0xdeadbee0);
}
