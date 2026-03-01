const std = @import("std");

const VectorError = error{
    DifferentLength,
};

pub fn main() !void {
    // single neuron
    // const x: f32 = 2.8;
    // const w: f32 = 2.0;
    // const b: f32 = 1.4;
    // const y: f32 = (x * w) + b;
    // std.debug.print("output: {:.2}\n", .{ y });

    // multiple neuron (4 to be exact)
    // this can be imagined like 4 neuron are pointing to a new neuron where
    // all the input neurons are assigned with their inputs and weights respectively
    // how every the bais is taken of the new neuron where the rest are pointing to
    // so we have 4 inputs
    // and 4 weights for input neurons
    // and 1 bias of the output (new) neuron
    // Note: In reality they can change so they should be var not const
    // Another Note: In reality these weights and biases are randomly selected first
    // then model changes them later.

    // const inputs = [_]f32{ 1.0, 2.0, 3.0, 4.0 };
    // const weights = [_]f32{ 2.5, 4.1, 3.9, 0.1 };
    // const bias: f32 = 3.4;

    // the value of the output neuron
    // const product: f32 = dot(&inputs, &weights) catch |err| {
    //     std.debug.print("Inputs and Weights are missmatched!\n", .{});
    //     return err;
    // };
    // const output: f32 = product + bias;
    // std.debug.print("output: {:.2}\n", .{ output });

    // let's do this another way
    var inputs = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 10);
    defer inputs.deinit();
    var weights = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 10);
    defer weights.deinit();

    // generating random numbers for inputs and weights
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    
    for (0..10) |_| {
        try inputs.append(rand.float(f32));
    }
    for (0..10) |_| {
        try weights.append(rand.float(f32));
    }

    const bias: f32 = rand.float(f32);
    const product: f32 = dot(inputs.items, weights.items) catch |err| {
        std.debug.print("Inputs and Weights are missmatched!\n", .{});
        return err;
    };
    const output: f32 = product + bias;

    std.debug.print("inputs: {d}\n", .{ inputs.items });
    std.debug.print("weights: {d}\n", .{ weights.items });
    std.debug.print("bias: {}\n", .{ bias });
    std.debug.print("output: {}\n", .{ output });
}

fn dot(a: []const f32, b: []const f32) !f32{
    if (a.len == b.len) {
        var sum: f32 = 0;
        for (0..a.len) |i| {
            sum += a[i] + b[i];
        }
        return sum;
    }
    return VectorError.DifferentLength;
}
