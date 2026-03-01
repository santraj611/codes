const std = @import("std");

pub fn main() void {
    // This is how you set multiline string
    const hello_world_in_c =
        \\#include <stdio.h>
        \\
        \\int main(int argc, char **argv) {
        \\    printf("hello world\n");
        \\    return 0;
        \\}
    ;

    std.debug.print("// hello world in C\n{s}", .{hello_world_in_c});
}
