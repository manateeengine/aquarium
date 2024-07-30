const aquarium = @import("aquarium");
const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var app = aquarium.App.init(allocator);
    defer app.deinit();

    _ = try app.open_window(aquarium.WindowParams{});

    app.run();
}
