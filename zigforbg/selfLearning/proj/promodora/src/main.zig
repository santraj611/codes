const std = @import("std");
const time = std.time;
const rl = @cImport({
    @cInclude("raylib.h");
});

pub fn main() anyerror!void {
    const second = 1_000_000_000; // 1 nano second
    var work_time: usize = 50 * 60 * second; // 50 Mins
    var break_time: usize = 5 * 60 * second; // 5 Mins

    // var cycle: u32 = 0;
    var is_break: bool = false;
    // var gpa = std.heap.GeneralPurposeAllocator(.{}) {};
    // defer _ = gpa.deinit();
    // var allocator = gpa.allocator();

    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 1080;
    const screenHeight = 720;
    const centerHeight = screenHeight / 2;
    const centerWidth = screenWidth / 2;

    rl.InitWindow(screenWidth, screenHeight, "Simple Promodoro App");
    defer rl.CloseWindow(); // Close window and OpenGL context

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------
        if (work_time <= 0) {
            is_break = true;
        }

        // and subtract that from work time
        work_time -= second;

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.BLACK);

        if (is_break) {
            const break_lable: [:0]const u8 = "Break Time";
            rl.DrawText(break_lable, centerWidth - break_lable.len * 15 , centerHeight - 15 * 5, 50, rl.LIGHTGRAY);
            var buf: [20]u8 = undefined;
            const break_time_lable: [:0]const u8 = try std.fmt.bufPrintZ(&buf, "{d}",
                .{ break_time / (60 * second)});
            rl.DrawText(break_time_lable,
            @as(c_int, @intCast(centerWidth - break_lable.len * 15)) ,
            centerHeight - 15, 50, rl.LIGHTGRAY);

            std.time.sleep(second);
            break_time -= second;
        }

        const work_lable: [:0]const u8 = "WORK TIME";
        rl.DrawText(work_lable, centerWidth - work_lable.len * 15 , centerHeight - 15 * 5, 50, rl.LIGHTGRAY);

        var buf: [20]u8 = undefined;
        const work_time_lable: [:0]const u8 = try std.fmt.bufPrintZ(&buf, "{d}",
            .{ work_time / (60 * second)});
        rl.DrawText(work_time_lable,
            @as(c_int, @intCast(centerWidth - work_time_lable.len * 15)) ,
            centerHeight - 15,
            50,
            rl.LIGHTGRAY);

        rl.DrawText("Break Time", 0, 0, 30, rl.SKYBLUE);
        //----------------------------------------------------------------------------------

        // sleep for 1 second
        std.time.sleep(second);
    }
}
