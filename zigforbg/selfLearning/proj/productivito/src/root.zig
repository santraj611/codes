const std = @import("std");
const dt = @import("datetime");
const sqlite = @import("sqlite");
const sqlDb = sqlite.Db;
const Allocator = std.mem.Allocator;
const Datetime = dt.datetime.Datetime;
const Date = dt.datetime.Date;
const Time = dt.datetime.Time;

pub const Period = struct {
    // id: usize,
    date: []const u8,         // e.g. "2025-06-25"
    start_time: []const u8,   // e.g. "2025-06-25 09:00:00"
    end_time: []const u8,     // e.g. "2025-06-25 10:00:00"
    duration_minutes: usize,
};


pub const DB = struct {
    db_path: []const u8,
    db_name: []const u8,

    pub fn initDb(self: *DB, allocator: Allocator) !sqlDb {
        // Create directory path if it doesn't exist
        try std.fs.cwd().makePath(self.db_path);

        // Create full path to database file
        const raw_path = try std.fs.path.join(allocator, &[_][]const u8{
            self.db_path,
            self.db_name,
        });

        // Allocate space for null-terminated version
        const db_file_path = try allocator.allocSentinel(u8, raw_path.len, 0);
        @memcpy(db_file_path[0..raw_path.len], raw_path);

        // Open SQLite connection
        var db = try sqlite.Db.init(.{
            .mode = sqlite.Db.Mode{ .File = db_file_path },
            .open_flags = .{
                .write = true,
                .create = true,
            },
            .threading_mode = .MultiThread,
        });

        const create_table_sql =
        \\ CREATE TABLE IF NOT EXISTS usage_data (
        \\     id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\     date DATE,
        \\     start_time DATETIME,
        \\     end_time DATETIME,
        \\     duration_minutes INTEGER
        \\ );
        ;

        // Prepare and execute the statement
        var stmt = try db.prepare(create_table_sql);
        defer stmt.deinit();

        try stmt.exec(.{}, .{});

        // std.debug.print("Database initialized at: {s}\n", .{db_file_path});

        return db;
    }

    pub fn exec(db: *sqlDb, query: []const u8, comptime T: type, data: T) !void {
        var stmt = try db.prepare(query);
        defer stmt.deinit();

        try stmt.exec(T, data);
    }
};

pub fn dbPath(ally: Allocator) ![]u8 {
    const home = std.posix.getenv("HOME");
    if (home) |h| {
        const db_path = try std.fs.path.join(ally,
            &[_][]const u8 { h, ".local", "share", "productivito", "database" });
        return db_path;
    } else {
        std.debug.print("Failed to resolve $HOME\n", .{});
        return error.NullHome;
    }
}

/// get current timezone
pub fn getUserTimezone(buf: *[std.fs.max_path_bytes]u8) ![]const u8 {
    if (std.posix.getenv("TZ")) |tz| {
        @memcpy(buf, tz);
    }

    const path = try std.fs.readLinkAbsolute("/etc/localtime", buf);
    const prefix = "/usr/share/zoneinfo/";
    if (std.mem.startsWith(u8, path, prefix)) {
        return path[prefix.len..]; // Strip prefix
    }

    return error.UnknownTimezone;
}

/// prints date to buffer
pub fn bufPrintDate(buf: []u8, date: Date) ![]u8 {
    const today_date: []u8 = try std.fmt.bufPrint(
        buf,
        "{}-{}-{}",
        .{ date.year, date.month, date.day });
    return today_date;
}

/// get current datetime
pub fn getCurrentTime() !Datetime {
    const max_path_bytes: usize = std.fs.max_path_bytes;
    var buf: [max_path_bytes]u8 = undefined;
    const tz_slice: []const u8 = try getUserTimezone(&buf);

    const tz: dt.datetime.Timezone = try dt.timezones.getByName(tz_slice);
    const datetime: Datetime = Datetime.now();
    return datetime.shiftTimezone(tz);
}

/// prints time to buffer
pub fn bufPrintTime(buf: []u8, time: Time) ![]u8 {

    const now: []u8 = try std.fmt.bufPrint(
        buf,
        "{}:{}:{}",
        .{ time.hour, time.minute, time.second });
    return now;
}

/// duration in minutes calculator
pub fn durationMinutes(start_time: Datetime, end_time: Datetime) usize {
    const start = start_time.toTimestamp(); // in milisec
    const end = end_time.toTimestamp(); // in milisec

    const delta: usize = @intCast(end - start); // in milisec
    const duration: usize = delta / ( 1000 * 60);
    return duration;

    // var total_mins: usize = 0;

    // Ignoring this problem for now
    // check if the date is same or not?
    // if (end_time.date.day > start_time.date.day) {
    //     const days_gap: u8 = end_time.date.day - start_time.date.day;
    // }

    // if (end_time.time.hour > start_time.time.hour) {
    //     // check if the hour is same or not?
    //     const hours_gape: u8 = end_time.time.hour - start_time.time.hour;
    //     total_mins += hours_gape * 60;
    // }
    //
    // if (end_time.time.minute > start_time.time.minute) {
    //     // then for mins and secs
    //     const minute_gape: u8 = end_time.time.minute - start_time.time.minute;
    //     total_mins += minute_gape;
    // }

    // return total_mins;
}

/// Auto saves Time
pub fn auto_save(data: Period, db: *sqlDb) !void {

    const query =
    \\INSERT INTO usage_data (date, start_time, end_time, duration_minutes) VALUES(?, ?, ?, ?)
    ;

    var stmt = try db.prepare(query);
    defer stmt.deinit();

    try stmt.exec(.{}, .{
        .date = data.date,
        .start_time = data.start_time,
        .end_time = data.end_time,
        .duration_minutes = data.duration_minutes,
    });
}

/// Checks if the user is Active or not?
pub fn is_user_active() ! bool {}
// def is_user_active() -> bool:
//     """
//     Checks if the user is actively interacting with the computer.
//
//     Returns:
//         bool: True if the user is active, False otherwise.
//     """
//     # Get initial CPU usage and disk I/O counters
//     initial_cpu_usage = psutil.cpu_percent(interval=1)
//     initial_disk_read = psutil.disk_io_counters().read_bytes
//     initial_disk_write = psutil.disk_io_counters().write_bytes
//
//     time.sleep(5)  # Wait for a short interval
//
//     # Get current CPU usage and disk I/O counters
//     current_cpu_usage = psutil.cpu_percent(interval=1)
//     current_disk_read, current_disk_write = psutil.disk_io_counters().read_bytes, psutil.disk_io_counters().write_bytes
//
//     # Calculate changes in CPU usage and disk I/O
//     cpu_usage_delta = abs(current_cpu_usage - initial_cpu_usage)
//     disk_read_delta = current_disk_read - initial_disk_read
//     disk_write_delta = current_disk_write - initial_disk_write
//
//     # Define thresholds for inactivity
//     cpu_idle_threshold = 5  # Example: CPU usage below 5%
//     disk_idle_threshold = 1024  # Example: Less than 1KB of disk activity
//
//     return cpu_usage_delta > cpu_idle_threshold or disk_read_delta > disk_idle_threshold or disk_write_delta > disk_idle_threshold

