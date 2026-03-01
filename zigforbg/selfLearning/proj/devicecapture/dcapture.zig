const std = @import("std");
const os = std.os;
const linux = os.linux;
const ioctl = linux.ioctl;

// Manually define the v4l2_capability struct
const v4l2_capability = extern struct {
    driver: [16]u8 align(1),
    card: [32]u8 align(1),
    bus_info: [32]u8 align(1),
    version: u32 align(1),
    capabilities: u32 align(1),
    device_caps: u32 align(1),
    reserved: [3]u32 align(1),
};

// Define the VIDIOC_QUERYCAP ioctl request
const VIDIOC_QUERYCAP = linux.IOR('V', 0, @sizeOf(v4l2_capability));
const CAP_VIDEO_CAPTURE = 0x00000001;

pub fn main() !void {
    // Step 1: "Open the camera app"
    const device_path = "/dev/video0";
    const file = try std.fs.openFileAbsolute(device_path, .{
        .mode = .read_write, // O_RDWR
    });
    defer file.close(); // Close the file when done
    const fd = file.handle;

    // Step 2: "Are you a camera?"
    const v4l2 = struct {
        pub const VIDIOC_QUERYCAP = 0x80685600; // Magic number for the "query capabilities" command
        pub const CAP_VIDEO_CAPTURE = 0x00000001; // Flag meaning "I can capture video"
    };

    var cap: v4l2_capability = undefined;
    const result = ioctl(fd, VIDIOC_QUERYCAP, @intFromPtr(&cap));
    if (linux.getErrno(result) != .SUCCESS) {
        std.debug.print("Error: {}\n", .{linux.getErrno(result)});
        return error.IOCTLFailed;
    }

    if (cap.capabilities & v4l2.CAP_VIDEO_CAPTURE == 0) {
        std.debug.print("This is NOT a video capture device!\n", .{});
        return error.NotACamera;
    }

    std.debug.print("Success! This is a video camera.\n", .{});
}
