const std = @import("std");

pub fn main() !void {
    var writer_buffer: [1024]u8 = undefined;
    const stdout_writer: std.fs.File.Writer = std.fs.File.writer(&writer_buffer);
    const w: *std.Io.Writer = &stdout_writer.interface;

    var reader_buffer: [1024]u8 = undefined;
    const stdin_reader: std.fs.File.Reader = std.fs.File.reader(&reader_buffer);
    const r: *std.Io.Reader = &stdin_reader.interface;
}
