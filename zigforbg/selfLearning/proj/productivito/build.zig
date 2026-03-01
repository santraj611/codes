//! Use `zig init --strip` next time to generate a project without comments.
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const raylib = raylib_dep.module("raylib"); // main raylib module
    const raygui = raylib_dep.module("raygui"); // raygui module
    const raylib_artifact = raylib_dep.artifact("raylib"); // raylib C library

    const sqlite = b.dependency("sqlite", .{
        .target = target,
        .optimize = optimize,
    });

    const pg = b.dependency("datetime", .{
        .target = target,
        .optimize = optimize,
    });

    const mod = b.addModule("productivito", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });

    const pomodoro = b.addModule("pomodoro", .{
        .root_source_file = b.path("src/pomodoro.zig"),
        .target = target,
    });

    const exe = b.addExecutable(.{
        .name = "productivito",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "productivito", .module = mod },
                .{ .name = "pomodoro", .module = pomodoro },
            },
        }),
    });

    // for src/main.zig
    exe.root_module.addImport("sqlite", sqlite.module("sqlite"));
    exe.root_module.addImport("datetime", pg.module("datetime"));

    // for src/pomodoro.zig
    exe.linkLibrary(raylib_artifact);
    pomodoro.addImport("raylib", raylib);
    pomodoro.addImport("raygui", raygui);

    // for src/root.zig
    mod.addImport("sqlite", sqlite.module("sqlite"));
    mod.addImport("datetime", pg.module("datetime"));

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const mod_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_mod_tests = b.addRunArtifact(mod_tests);

    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
    test_step.dependOn(&run_exe_tests.step);
}
