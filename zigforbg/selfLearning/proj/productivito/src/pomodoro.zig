const std = @import("std");
const rl = @cImport(
    @cInclude("raylib.h")
);

pub fn main() !void {
    // ------------------------------------------------------- //
    // Raylib configuration & window(s)
    const screenWidht = 800;
    const screenHight = 450; 

    rl.InitWindow(screenWidht, screenHight, "Productivito");
    defer rl.CloseWindow();

    rl.SetTargetFPS(60);

    // setting variables

    // main loop
    while (!rl.WindowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.WHITE);

        rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY);
        //----------------------------------------------------------------------------------
    }

}
