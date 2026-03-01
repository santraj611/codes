const std = @import("std");
const usr = @import("usr.zig");

const User = usr.User;

pub fn main() void {
    const p1: User = User{ .name = "damaraju", .age = 19 };
    const p2: User = User{ .name = "alex", .age = 20 };
    const p3: User = User{ .name = "proper_bug", .age = 31 };

    printuser(p1);
    printuser(p2);
    printuser(p3);
}

fn printuser(person: User) void {
    std.debug.print("name: {s}, age: {d}\n", .{ person.name, person.age });
}
