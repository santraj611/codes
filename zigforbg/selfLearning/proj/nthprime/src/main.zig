const std = @import("std");
const cos = std.math.cos;
const floor = std.math.floor;
const pow = std.math.pow;
const pi = std.math.pi;

pub fn main() !void {
    std.debug.print("{}\n", .{nthPrime(5)});
}

fn fec(n: u64) u64 {
    if (n == 0 or n == 1) return 1;
    const fectorial: u64 = n * fec(n - 1);
    return fectorial;
}

fn nthPrime(n: u64) u64 {
    var sum: u64 = 0;
    // for (1..pow(u64, 2, n)) |i| {
    // const X = pow(u64, n / dinoM(@intCast(i)), 1 / n);
    //     sum += floor(X);
    // }

    const limit: u64 = pow(u64, 2, n);
    var i: u64 = 1;
    while (i <= limit) : (i += 1) {
        const ratio: f64 = @as(f64, @floatFromInt(n)) / @as(f64, @floatFromInt(dinoM(i)));
        const nInverse: f64 = @as(f64, @floatFromInt(1)) / @as(f64, @floatFromInt(n));
        const X = pow(f64, ratio, nInverse);
        sum += @intFromFloat(floor(X));
    }

    return 1 + sum;
}

fn dinoM(i: u64) u64 {
    // i is the upper limit of the sum
    var sum: u64 = 0;

    // for (1..i) |j| {
    //     const x = cos((fec(@intCast(j - 1)) + 1) * pi / j) * cos((fec(@intCast(j - 1)) + 1) * pi / j);
    //     sum += pow(u64, @intCast(floor(x)), 2);
    // }

    var j: u64 = 1;
    const limit: u64 = i;
    while (j <= limit) : (j += 1) {
        const theta: f64 = @as(f64, @floatFromInt(fec(j - 1) + 1)) / @as(f64, @floatFromInt(j));
        const thetaPi: f64 = theta * pi;
        const x = cos(thetaPi) * cos(thetaPi);
        sum += pow(u64, @intFromFloat(floor(x)), 2);
    }

    return sum;
}
