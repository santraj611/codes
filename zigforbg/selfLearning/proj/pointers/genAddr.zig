const std = @import("std");
const Random = std.Random;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var buff = try allocator.alloc(u8, 64);
    defer allocator.free(buff);

    var prng = Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const random: Random = prng.random();

    const lucky_number: u8 = random.int(u8);

    // Store the number in the buffer
    buff[0] = lucky_number;

    // Print the pointer (address) of the lucky_number
    // std.debug.print("lucky_number: {} at address: {p}\n", .{ lucky_number, &lucky_number });

    // Print the address of the buffer
    std.debug.print("lucky_number: {} at address: {p}\n", .{ buff[0], &buff[0] });
    std.debug.print("Type of ptr: {}\n", .{@TypeOf(&buff[0])});
}
