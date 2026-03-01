const std = @import("std");

pub fn main() !void {
    //data set
    var X: [4]u8 = [4]u8 {0, 1, 2, 3};
    var Y: [4]u8 = [4]u8 {3, 5, 7, 9};

    std.debug.print("X: {d}\n", .{X});
    std.debug.print("Y: {d}\n", .{Y});
    
    // function is y = f(x) = 2x + 3

    // generating random values for weight and bias
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const w = rand.float(f32) * 100;
    const b = rand.float(f32) * 100;

    std.debug.print("Weight: {:.3}\n", .{w});
    std.debug.print("Bias: {:.3}\n", .{b});

    // learning rate
    const eta = 0.001;

    const epochs = 2000;

    comptime var epoch = 0;
    while (epoch < epochs) : (epoch += 1) {
        // forward pass
        const Y_pred = w * X + b; // Model's Prediction
    
        const diff = matSub(&Y_pred[0..], &Y[0..]);
        var value = matPow(2, diff);

        // Compute loss (Mean Squared Error)
        const loss = mean(&value[0..]);

        // Compute gradients
        value = 2 * (Y_pred - Y) * X;
        const dL_dw = mean(&value);  // dL/dw
        value = 2 * (Y_pred - Y);
        const dL_db = mean(&value);      // dL/db

        // Gradient descent update
        w -= eta * dL_dw;
        b -= eta * dL_db;

        // Print progress every 100 epochs
        if (epoch % 100 == 0) {
            std.debug.print("Epoch {}: Loss = {}, w = {}, b = {}\n", .{epoch, loss, w, b});
        }

    std.debug.print("Final learned equation: y = {:.2f}x + {:.2f}\n", .{w, b});

        }
}

fn mean(arr: *const []u8) u32 {
    var sum: u32 = 0;
    for (arr.*) |val| {
        sum += val;
    }
    return sum;
}

fn matSub(matrix1: *[]u8, matrix2: *[]u8) ![]u8 {
    if (matrix1.*.len != matrix2.*.len) {
        error.CouldNotSubtract;
    }
    var matrix3: [matrix1.*.len]u8 = undefined;
    comptime var i = 0;
    while (i < matrix3.len) : (i += 1) {
        matrix3[i] = matrix1.*[i] - matrix2.*[i];
    }
    
    return matrix3;
}

fn matScalerMultiply(s: u32, mat: *[]u8) void {
    for (mat) |*byte| {
        byte.* *= s;
    }
}

fn matPow(p: u32, mat: *[]u8) void {
    for (mat) |*byte| {
        byte.* = std.math.pow(u8, byte.*, p);
    }
}
