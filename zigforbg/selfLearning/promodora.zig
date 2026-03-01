const std = @import("std");

pub fn main() !void {
    var work_time: u32 = try getIntegerInput("Enter work time in minutes: ");
    var break_time: u32 = try getIntegerInput("Enter break time in minutes: ");

    var cycle: u32 = 0;
    var is_break: bool = false;
    var gpa = std.heap.GeneralPurposeAllocator(.{}) {};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    while (true) {
        if (is_break) {
            std.debug.print("Break time! {d} minutes remaining.\n", .{break_time});
            break_time -= 1;
            if (break_time == 0) {
                std.debug.print("Break over! Back to work.\n", .{});
                is_break = false;
                cycle += 1;
                if (cycle % 4 == 0) {
                    std.debug.print("Long break! {d} minutes remaining.\n", .{work_time + 15});
                    std.time.sleep(1000 * 60 * (work_time + 15));
                } else {
                    std.debug.print("Next work session!\n", .{});
                    std.time.sleep(1000 * 60 * work_time);
                }
            }
        } else {
            std.debug.print("Work time! {d} minutes remaining.\n", .{work_time});
            work_time -= 1;
            if (work_time == 0) {
                std.debug.print("Work over! Time for a break.\n", .{});
                is_break = true;
                break_time = try getIntegerInput("Enter break time in minutes: ");
            }
        }

        std.debug.print("Pomodora cycle: {d}\n", .{cycle});
        std.debug.print("Press Enter to continue, or type 'q' to quit: ", .{});
        const line = try std.io.getStdIn().reader().readUntilDelimiterOrEofAlloc(allocator, '\n', 100);
        const l = line orelse unreachable;
        defer allocator.free(line.?);
        if (l.len > 0 and l[0] == 'q') {
            break;
        }
    }
}

fn getIntegerInput(prompt: []const u8) !u32 {
    std.debug.print("{s} ", .{prompt});
    const input = try std.io.getStdIn().reader().readUntilDelimiterOrEofAlloc(std.heap.page_allocator, '\n', 100);
    const usrinpt = input.?;
    return try std.fmt.parseInt(u32, usrinpt, 10);
}
