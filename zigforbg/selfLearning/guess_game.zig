const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });

    const rand = prng.random();
    var rounds: usize = 10;

    const correct_guess: u8 = rand.int(u8);

    std.debug.print("Guess The random number (between 0 and 255)\n", .{});
    std.debug.print("Hint: {p}\n", .{&correct_guess});
    std.debug.print("You got {} guesses\n", .{rounds});

    var user_guess = try user_int(allocator);
    std.debug.print("\n", .{});

    while (rounds - 1 > 0) : (rounds -= 1) {
        if (user_guess == correct_guess) {
            std.debug.print("You win!!!\n", .{});
            return;
        } else if (user_guess > correct_guess) {
            std.debug.print("Guess is more then number!\n", .{});
        } else if (user_guess < correct_guess) {
            std.debug.print("Guess is less then number!\n", .{});
        }

        std.debug.print("That is Incorrect!\n", .{});
        std.debug.print("\n", .{});
        std.debug.print("remaining guess: {}\n", .{rounds - 1});
        std.debug.print("Another Guess\n", .{});
        user_guess = try user_int(allocator);
        std.debug.print("\n", .{});
    }

    std.debug.print("You are out of guesses\n", .{});
    std.debug.print("You loos\n", .{});
    std.debug.print("correct guess was {}\n", .{correct_guess});
}

fn user_int(allocator: Allocator) !u8{
    // reading user input
    const std_reader = std.io.getStdIn().reader();
    const user: ?[]u8 = try std_reader.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024);
    const user_slice: []u8 = user orelse unreachable;

    // converting to u8
    const user_number: u8 = try std.fmt.parseInt(u8, user_slice, 10);
    return user_number;
}
