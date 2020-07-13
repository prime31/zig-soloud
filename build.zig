const builtin = @import("builtin");
const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    // windows static lib compilation of FNA causes an SDL header issue so its forced as exe_compiled
    var lib_type = b.option(i32, "lib_type", "0: static, 1: dynamic, 2: exe compiled") orelse 0;
    if (target.isWindows()) lib_type = 2;

    var exe = b.addExecutable("run", "src/soloud.zig");
    exe.setBuildMode(b.standardReleaseOptions());
    exe.setOutputDir("zig-cache/bin");

    const soloud_build = @import("deps/soloud/build.zig");
    soloud_build.linkArtifact(b, exe, target, @intToEnum(soloud_build.LibType, lib_type));

    const run_cmd = exe.run();
    const exe_step = b.step("run", "run");
    exe_step.dependOn(&run_cmd.step);
}
