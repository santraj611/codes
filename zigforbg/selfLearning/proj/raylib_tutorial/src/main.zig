const std = @import("std");
const c = @cImport({
    @cInclude("raylib.h");
});

const initialScreenWidth: u32 = 1080;
const initialScreenHeight: u32 = 720;

const Vec2 = struct {
    x: f32,
    y: f32,

    pub fn add(self: Vec2, other: Vec2) Vec2 {
        return Vec2{ .x = self.x + other.x, .y = self.y + other.y };
    }

    pub fn scaler(self: Vec2, factor: f32) Vec2 {
        return Vec2{ .x = self.x * factor, .y = self.y * factor };
    }
};

const Ball = struct {
    radius: f32,

    acceleration: Vec2 = Vec2{ .x = 0, .y = 0 },
    velocity: Vec2 = Vec2{ .x = 0, .y = 0 },
    position: Vec2 = Vec2{ .x = initialScreenWidth / 2, .y = initialScreenHeight / 2 },
};

pub fn main() !void {
    // Initialization
    //--------------------------------------------------------------------------------------
    c.InitWindow(initialScreenWidth, initialScreenHeight, "Learning Ball");
    defer c.CloseWindow(); // Close window and OpenGL context

    c.SetTargetFPS(60); // 60 FPS for smoother resizing experience
    //--------------------------------------------------------------------------------------
    var ball: Ball = Ball{ .radius = 16 };

    // Main loop
    while (!c.WindowShouldClose()) { // Detect window close button or ESC key
        // Looking for keypress
        if (c.IsKeyDown(c.KEY_Q)) {
            break;
        }

        // Update
        //----------------------------------------------------------------------------------

        if (c.IsKeyDown(c.KEY_RIGHT)) {
            ball.position.x += 5;
        }
        if (c.IsKeyDown(c.KEY_LEFT)) {
            ball.position.x -= 5;
        }
        if (c.IsKeyDown(c.KEY_UP)) {
            ball.position.y -= 5;
        }
        if (c.IsKeyDown(c.KEY_DOWN)) {
            ball.position.y += 5;
        }

        // Logic
        //----------------------------------------------------------------------------------
        if (ball.position.x >= initialScreenWidth) {
            ball.position.x = initialScreenWidth;
        }
        if (ball.position.x <= 0) {
            ball.position.x = 0;
        }
        if (ball.position.y >= initialScreenHeight) {
            ball.position.y = initialScreenHeight;
        }
        if (ball.position.y <= 0) {
            ball.position.y = 0;
        }

        // Draw
        //----------------------------------------------------------------------------------
        c.BeginDrawing();
        defer c.EndDrawing();

        c.ClearBackground(c.BLACK);

        // c.DrawCircle(ball.position.x, ball.position.y, ball.radius, c.BLUE);
        c.DrawCircle(
            @intFromFloat(ball.position.x),
            @intFromFloat(ball.position.y),
            ball.radius,
            c.BLUE,
);
        //----------------------------------------------------------------------------------
    }
}
