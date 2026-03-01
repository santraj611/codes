const std = @import("std");
const testing = std.testing;
const expect = testing.expect;

test "switch statement" {
    var x: i8 = 10;
    switch (x) {
        -1...1 => {
            x = -x;
        },
        10, 100 => {
            //special considerations must be made
            //when dividing signed integers
            x = @divExact(x, 10);
        },
        else => {},
    }
    try expect(x == 1);
}

test "switch expression" {
    var x: i8 = 10;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 1);
}

test "role in switch" {
    const Role = enum {
        SE, DPE, DE, DA, PM, PO, KS
    };

    var area: []const u8 = undefined;
    const role = Role.SE;

    switch (role) {
        .PM, .SE, .DPE, .PO => {
            area = "Platform";
        },
        .DE, .DA => {
            area = "Data & Analytics";
        },
        .KS => {
            area = "Sales";
        },
    }

    try testing.expectEqualSlices(u8, area, "Platform");
}

test "range in switch statement" {
    const level: u8 = 4;
    const category = switch (level) {
        0...25 => "beginner",
        26...75 => "intermediary",
        76...100 => "professional",
        else => {
            @panic("Not supported level!");
        },
    };

    try testing.expectEqualSlices(u8, category, "beginner");
}

test "labels with switch" {
    xsw: switch (@as(u8, 1)) {
        1 => {
            std.debug.print("First branch\n", .{});
            continue :xsw 2;
        },
        2 => continue :xsw 3,
        3 => return,
        4 => {},
        else => {
            std.debug.print(
                "Unmatched case, value: {d}\n", .{@as(u8, 1)}
            );
        },
    }
}
