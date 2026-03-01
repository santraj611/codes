const std = @import("std");

const Role = enum {
    son,
    daughter,
};

const Character = struct {
    role: Role,
    gold: u8,
    xp: u8,
    health: u8 = 100,
    elder: ?*Character = null,
};

pub fn main() void {
    var child1: Character = Character{
        .gold = 100,
        .xp = 200,
        .role = Role.daughter,
    };

    var child2: Character = Character{
        .gold = 50,
        .xp = 100,
        .elder = &child1,
        .role = Role.daughter,
    };

    var child3: Character = Character{
        .gold = 10,
        .xp = 50,
        .elder = &child2,
        .role = Role.son,
    };

    printcharacter(&child3);
}

fn printcharacter(char: *Character) void {
    const role = switch (char.role) {
        Role.son => "son",
        Role.daughter => "daughter",
    };

    std.debug.print("Health: {}, Gold: {}, XP: {}, Role: {s}\n", .{ char.health, char.gold, char.xp, role });

    if (char.elder) |elder| {
        std.debug.print("  Elder: ", .{});
        printcharacter(elder);
    }
}
