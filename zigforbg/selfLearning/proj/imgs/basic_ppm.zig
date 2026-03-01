const std = @import("std");
const math = std.math;

pub fn main() !void {
    const w: u16 = 512;
    const h: u16 = 512;

    var file = std.fs.cwd().createFile("img.ppm", .{ .read = true }) catch @panic("Failed to create img.ppm file");
    defer file.close();

    const writer = file.writer();

    // P6 header: "P6\n<width> <height>\n<maxval>\n"
    const header = "P6\n{d} {d}\n255\n";
    _ = try writer.print(header, .{ w, h });

    var y: usize = 0;
    while (y < h) : (y += 1) {
        var x: usize = 0;
        while (x < w) : (x += 1) {
            // simple procedural colors
            const fx: f32 = @as(f32, @floatFromInt(x)) / (w - 1);
            const fy: f32 = @as(f32, @floatFromInt(y)) / (h - 1);

            // radial mask for a circle
            const cx: f32 = @as(f32, @floatFromInt(x)) - @as(f32, w) * 0.5;
            const cy: f32 = @as(f32, @floatFromInt(y)) - @as(f32, h) * 0.5;

            const r: f32 = math.sqrt(cx*cx + cy*cy);
            const mask: f32 = if (r < 180.0) 1.0 else 0.0;

            const R: u8 = @intFromFloat(255 * fx);
            const G: u8 = @intFromFloat(255 * fy);
            const B: u8 = @intFromFloat(255 * (0.5 + 0.5*mask));

            const pixel: [3]u8 = .{ R, G, B };
            _ = try writer.write(&pixel);
        }
    }
}
