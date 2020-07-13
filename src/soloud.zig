const std = @import("std");
const soloud = @import("soloud");

pub fn main() !void {
    var instance: soloud.Soloud = undefined;
    std.debug.print("go: {}\n", .{soloud.Soloud_init(&instance)});
}
