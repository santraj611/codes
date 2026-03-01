const std = @import("std");
const pdvt = @import("productivito");
const sqlite = @import("sqlite");
const sqlDb = sqlite.Db;
const dt = @import("datetime");
const Date = dt.datetime.Date;
const Time = dt.datetime.Time;
const DateTime = dt.datetime.Datetime;
const Period = pdvt.Period;

var interrupted = std.atomic.Value(bool).init(false);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const ally = gpa.allocator();

    // ------------------------------------------------------- //
    // Define and install signal handler
    const sa = std.os.linux.Sigaction{
        .handler = .{ .handler = handle_sigint },
        .mask = std.os.linux.empty_sigset,
        .flags = 0,
    };

    // Use SIGINT (Ctrl+C),
    _ = std.os.linux.sigaction(std.os.linux.SIG.INT, &sa, null);
    // Use SIGTERM (for shutdowns),
    _ = std.os.linux.sigaction(std.os.linux.SIG.TERM, &sa, null);

    // ------------------------------------------------------- //
    const db_path: []u8 = try pdvt.dbPath(ally);
    var database = pdvt.DB{ .db_path = db_path, .db_name = "usage.db" };
    var db: sqlDb = try database.initDb(ally);
    defer db.deinit();

    // ------------------------------------------------------- //
    // get current date
    const buf_date: []u8 = try ally.alloc(u8, 100);
    const buf_start_time: []u8 = try ally.alloc(u8, 100);
    const buf_end_time: []u8 = try ally.alloc(u8, 100);
    defer ally.free(buf_date);
    defer ally.free(buf_start_time);
    defer ally.free(buf_end_time);

    const today: DateTime = try pdvt.getCurrentTime();
    const date_today_slice: []const u8 =  try pdvt.bufPrintDate(buf_date, today.date);
    // std.debug.print("date_today_slice: {s}\n", .{ date_today_slice });

    // get current time
    var start_time: DateTime = try pdvt.getCurrentTime();
    var start_time_slice: []const u8 = try pdvt.bufPrintTime(buf_start_time, start_time.time);

    // ------------------------------------------------------- //
    const sleep_step_ns = 1_000_000_000; // 1 second
    const total_sleep_time_ns = 60 * 10 * sleep_step_ns; // 10 minutes

    // inside your if block
    var slept_ns: u64 = 0;
    while (slept_ns < total_sleep_time_ns) {

        if (!interrupted.load(.seq_cst)) {
            // wait for slept_ns to reach 10 mins
            std.time.sleep(sleep_step_ns);
            slept_ns += sleep_step_ns;
            
            if (slept_ns != total_sleep_time_ns) continue;
            slept_ns = 0;

            // getting end time
            const end_time: DateTime = try pdvt.getCurrentTime();
            clearBuf(buf_end_time);
            const end_time_slice: []const u8 = try pdvt.bufPrintTime(buf_end_time, end_time.time);

            // getting duration_minutes
            const duration_minutes = pdvt.durationMinutes(start_time, end_time);

            const data: Period = .{
                .date = date_today_slice,
                .start_time = start_time_slice,
                .end_time = end_time_slice,
                .duration_minutes = duration_minutes
            };

            // std.debug.print("DATA: \ndate: {s}\nstart_time: {s}\nend_time: {s}\nduration_minutes: {}\n", 
            //     .{ data.date, data.start_time, data.end_time, data.duration_minutes });

            // then call the auto_save function
            try pdvt.auto_save(data, &db); // this failed

            // reset start_time
            start_time = try pdvt.getCurrentTime();
            clearBuf(buf_start_time);
            start_time_slice = try pdvt.bufPrintTime(buf_start_time, start_time.time);

        } else {
            // getting end time
            const end_time: DateTime = try pdvt.getCurrentTime();
            clearBuf(buf_end_time);
            const end_time_slice: []const u8 = try pdvt.bufPrintTime(buf_end_time, end_time.time);

            // getting duration_minutes
            const duration_minutes = pdvt.durationMinutes(start_time, end_time);
            const data: Period = .{
                .date = date_today_slice,
                .start_time = start_time_slice,
                .end_time = end_time_slice,
                .duration_minutes = duration_minutes
            };

            // std.debug.print("DATA: \ndate: {s}\nstart_time: {s}\nend_time: {s}\nduration_minutes: {}\n", 
            //     .{ data.date, data.start_time, data.end_time, data.duration_minutes });

            // save the work and exit
            try pdvt.auto_save(data, &db);
            break;
        }
    }
    std.process.exit(0);
}

/// Catch termination signals
/// Signal handler must be signal-safe (no heap, no complex I/O)
pub fn handle_sigint(sig: i32) callconv(.C) void {
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

    interrupted.store(true, .seq_cst);
}

/// clear buffer
fn clearBuf(buf: []u8) void {
    for (buf) |*byte| {
        byte.* = 0;
    }
}
