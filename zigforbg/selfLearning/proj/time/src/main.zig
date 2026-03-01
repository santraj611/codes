const std = @import("std");
const dt = @import("datetime");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // const date = try dt.datetime.Date.create(2019, 12, 25);
    // const next_year = date.shiftDays(7);
    // std.debug.print("Next Year: {}\n", .{next_year.year});
    // std.debug.print("Next Year Month: {}\n", .{next_year.month});
    // std.debug.print("Next Year Day: {}\n", .{next_year.day});

    // In UTC
    // const now = dt.datetime.Datetime.now();
    // const now_str = try now.formatHttp(allocator);
    // defer allocator.free(now_str);
    // std.debug.print("Time Zone: {s}\n", .{now.zone.name});
    // std.debug.print("The time is now: {s}\n", .{now_str});
    // The time is now: Fri, 20 Dec 2019 22:03:02 UTC

    // In India
    const tz = dt.timezones.Asia.Kolkata;
    const now = dt.datetime.Datetime.now();
    const time = dt.datetime.Datetime.shiftTimezone(now, tz);
    const time_str = try time.formatHttp(allocator);
    defer allocator.free(time_str);

    const only_date = now.date;
    const only_time = time.time;

    std.debug.print("Time In India: {s}\n", .{time_str});
    std.debug.print("Year: {}\n", .{only_date.year});
    std.debug.print("Month: {} ({s})\n", .{only_date.month, only_date.monthName()});
    std.debug.print("Day: {}\n", .{only_date.day});

    std.debug.print("Hours: {}\n", .{only_time.hour});
    std.debug.print("Mins: {}\n", .{only_time.minute});
    std.debug.print("Sec: {}\n", .{only_time.second});
}
