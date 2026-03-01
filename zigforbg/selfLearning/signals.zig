const std = @import("std");

pub fn main() !void {
    // Define and install signal handler
    const sa = std.os.linux.Sigaction{
        .handler = .{ .handler = handle_sigint },
        .mask = std.os.linux.empty_sigset,
        .flags = 0,
    };

    // Use SIGINT (Ctrl+C), not SIGTERM
    _ = std.os.linux.sigaction(std.os.linux.SIG.INT, &sa, null);
    _ = std.os.linux.sigaction(std.os.linux.SIG.TERM, &sa, null);

    // Simulate work
    while (true) {
        std.debug.print("Running... Press Ctrl+C to exit.\n", .{});
        std.time.sleep(1_000_000_000); // sleep 1 second
    }
}

/// Signal handler must be signal-safe (no heap, no complex I/O)
fn handle_sigint(sig: i32) callconv(.C) void {
    switch (sig) {
        2 => {
            // Writing directly to stderr using syscall is signal-safe
            const msg = "Received Ctrl+C (SIGINT). Exiting...\n";
            _ = std.os.linux.write(2, msg, msg.len); // FD 2 = stderr
        },
        15 => {
            const msg = "Received (SIGTERM). Exiting...\n";
            _ = std.os.linux.write(2, msg, msg.len); // FD 2 = stderr
        },
        else => {
            const msg = "Received (idk something). Exiting...\n";
            _ = std.os.linux.write(2, msg, msg.len); // FD 2 = stderr
        }
    }

    // Exit directly from handler (optional)
    std.os.linux.exit(0);
}
