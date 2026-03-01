const print = @import("std").debug.print;

const linkNode = struct { val: u32, next: *linkNode = undefined, visit: bool = false };

pub fn main() void {
    // Making nodes
    var n1: linkNode = linkNode{ .val = 1 };
    var n2: linkNode = linkNode{ .val = 2 };
    var n3: linkNode = linkNode{ .val = 3 };

    // Connecting them
    n1.next = &n2;
    n2.next = &n3;
    n3.next = &n1;

    printNodes(&n1);
}

fn printNodes(n: *linkNode) void {
    var pn = n;
    while (!pn.visit) {
        print("{d} ", .{pn.val});
        pn.visit = true;
        pn = pn.next;
        if (!pn.visit) print("-> ", .{});
    }
}
