const std = @import("std");
const expect = std.testing.expect;

test "simple while loop" {
    var i: usize = 0;
    while (i < 10) {
        if (i == 5) break;
        i += 1;
    }
    try expect(i == 5);
}

test "while loop continue expression" {
    var i: usize = 0;
    while (i < 10) : (i += 1) {}
    try expect(i == 10);
}

test "while with else" {
    var i: usize = 0;
    const is_ten: bool = blk: {
        while (i < 12) : (i += 3) {
            if (i == 10) break :blk true;
        }
        break :blk false;
    };
    try expect(is_ten == false);
}

test "while null capture" {
    var sum1: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| {
        sum1 += value;
    }
    try expect(sum1 == 3);

    // null capture with an else block
    var sum2: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| {
        sum2 += value;
    } else {
        try expect(sum2 == 3);
    }

    // null capture with a continue expression
    var i: u32 = 0;
    var sum3: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| : (i += 1) {
        sum3 += value;
    }
    try expect(i == 3);
}

var numbers_left: u32 = undefined;
fn eventuallyNullSequence() ?u32 {
    return if (numbers_left == 0) null else blk: {
        numbers_left -= 1;
        break :blk numbers_left;
    };
}
