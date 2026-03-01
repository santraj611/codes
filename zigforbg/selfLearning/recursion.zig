const expect = @import("std").testing.expect;

// xn = xn-1 + xn-2 and x0=0 x1 = 1
fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);
    try expect(x == 55);
}
