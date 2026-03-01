const std = @import("std");

// Mirror of C's `struct winsize` from <sys/ioctl.h>
pub const Winsize = extern struct {
    ws_row: u16,
    ws_col: u16,
    ws_xpixel: u16,
    ws_ypixel: u16,
};

pub fn main() anyerror!void {
    // 1) File descriptor for stdout
    const fd = std.os.linux.STDOUT_FILENO;

    // 2) Prepare the Winsize struct (uninitialized)
    var w: Winsize = undefined;

    // 3) TIOCGWINSZ request code (Linux)
    const req: u32 = 0x5413;

    // 4) Call ioctl: signature is fn ioctl(fd: fd_t, request: u32, arg: usize) usize
    //    We convert &w to usize via @ptrToInt, per Zig’s ABI requirements.
    const result: usize = std.os.linux.ioctl(fd, req, @intFromPtr(&w));

    // 5) Check for error: ioctl returns (usize)-1 on failure
    if (result == @as(isize, @intCast(-1))) {
        const err = std.os.linux.errno();
        std.debug.print("ioctl failed: errno={}\n", .{err});
        return error.IoctlFailed;
    }

    // 6) Print the retrieved rows and columns
    // std.debug.print("Rows: {}, Cols: {}\n", .{ w.ws_row, w.ws_col });

    for (0.. w.ws_col) |_| {
        std.debug.print("-", .{});
    }

    for (0..w.ws_row - 2) |_| {
        std.debug.print("|\n", .{});
    }

    for (0.. w.ws_col) |_| {
        std.debug.print("-", .{});
    }
}
