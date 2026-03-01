const std = @import("std");

const ANSI_COLOR_RED = "\x1b[31m";
const ANSI_COLOR_GREEN = "\x1b[32m";
const ANSI_COLOR_YELLOW = "\x1b[33m";
const ANSI_COLOR_BLUE = "\x1b[34m";
const ANSI_COLOR_MAGENTA = "\x1b[35m";
const ANSI_COLOR_CYAN = "\x1b[36m";
const ANSI_COLOR_RESET = "\x1b[0m";

pub fn main() void {
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_RED, "This text is RED!", ANSI_COLOR_RESET, "\n" });
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_GREEN, "This text is GREEN!", ANSI_COLOR_RESET, "\n" });
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_YELLOW, "This text is YELLOW!", ANSI_COLOR_RESET, "\n" });
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_BLUE, "This text is BLUE!", ANSI_COLOR_RESET, "\n" });
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_MAGENTA, "This text is, MAGENTA!", ANSI_COLOR_RESET, "\n" });
    std.debug.print("{s}{s}{s}{s}", .{ ANSI_COLOR_CYAN, "This text is CYAN!", ANSI_COLOR_RESET, "\n" });
}
