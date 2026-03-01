const std = @import("std");

pub fn main() !void {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    // make a input layer of 20 neurons each having some random input value
    var input_layer = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 20);
    defer input_layer.deinit();
    for (0..input_layer.capacity) |_| {
        try input_layer.append(rand.float(f32));
    }

    // fist hidden layer of 100 neurons
    var first_hidden_layer = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 100);
    defer first_hidden_layer.deinit();
    // for (0..first_hidden_layer.capacity) |_| {
    //     try first_hidden_layer.append(rand.float(f32));
    // }

    // now weights
    // for each neuron in first_hidden_layer we gonna need total no of input_layer (20)
    // so we will have an array of [100][20]f32
    // const x: [100][20]f32 = undefined;
    var weights = try std.ArrayList(std.ArrayList(f32)).initCapacity(std.heap.page_allocator, 100);
    defer {
        // Free all inner lists before freeing the outer list
        for (weights.items) |*inner_list| {
            inner_list.deinit();
        }
        weights.deinit();
    }
    for (0..weights.capacity) |_| {
        var ws = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 20);
        for (0..ws.capacity) |_| {
            try ws.append(rand.float(f32));
        }
        try weights.append(ws);
    }

    // biases are gonna be, The number of neurons in first_hidden_layer (100)
    var biases = try std.ArrayList(f32).initCapacity(std.heap.page_allocator, 100);
    defer biases.deinit();
    for (0..biases.capacity) |_| {
        try biases.append(rand.float(f32));
    }

    // for the time being let's just try to print all the info
    // std.debug.print("input_layer: {d}\n", .{ input_layer.items });
    // std.debug.print("first_hidden_layer: {d}\n", .{ first_hidden_layer.items });
    // std.debug.print("biases for first_hidden_layer: {d}\n", .{ biases.items });

    // for weights
    // for (0..weights.items.len) |i| {
    //     std.debug.print("neuron {d}: {d}\n", .{ i + 1, weights.items[i].items });
    // }

    // MISTAKES
    // MISTAKE NO 1.) We do not assign input values by ourselves for hidden layers
    // so assigning creating first_hidden_layer was a mistakes
    // we need to calculate it not randomely set it.
    for (0..first_hidden_layer.capacity) |i| {
        const product: f32 = try dot(input_layer.items, weights.items[i].items);
        const output: f32 = product + biases.items[i];
        try first_hidden_layer.append(output);
    }
    std.debug.print("first_hidden_layer: {d}\n", .{ first_hidden_layer.items });
}

fn dot(a: []const f32, b: []const f32) !f32{
    if (a.len == b.len) {
        var sum: f32 = 0;
        for (0..a.len) |i| {
            sum += a[i] + b[i];
        }
        return sum;
    }
    return error.DifferentLength;
}
