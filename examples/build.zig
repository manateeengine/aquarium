const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const aquarium = b.dependency("aquarium", .{});

    const open_window_exe = b.addExecutable(.{
        .name = "examples",
        .root_source_file = b.path("src/open_window.zig"),
        .target = target,
        .optimize = optimize,
    });
    open_window_exe.root_module.addImport("aquarium", aquarium.module("aquarium"));
    b.installArtifact(open_window_exe);
    const open_window_run_step = b.step("run", "Build and run example: Open Window");
    const open_window_run_cmd = b.addRunArtifact(open_window_exe);
    if (b.args) |args| {
        open_window_run_cmd.addArgs(args);
    }
    open_window_run_cmd.step.dependOn(b.getInstallStep());
    open_window_run_step.dependOn(&open_window_run_cmd.step);
}
