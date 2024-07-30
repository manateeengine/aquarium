const std = @import("std");
const window = @import("window.zig");

/// A windowed application and system event loop manager
pub const App = struct {
    next_window_id: u16,
    windows: std.AutoHashMap(u16, window.Window),
    pub fn init(allocator: std.mem.Allocator) App {
        const windows = std.AutoHashMap(u16, window.Window).init(allocator);
        return App{
            .next_window_id = 1,
            .windows = windows,
        };
    }

    pub fn open_window(self: *App, params: window.WindowParams) !window.Window {
        const new_window = window.Window.init(self.next_window_id, params);
        _ = try self.windows.put(self.next_window_id, new_window);
        self.next_window_id += 1;
        return new_window;
    }

    pub fn run(self: *App) void {
        _ = self;
        // TODO: Implement system event loops
    }

    pub fn deinit(self: *App) void {
        var windows_iterator = self.windows.iterator();
        while (windows_iterator.next()) |current_window| {
            current_window.value_ptr.deinit();
        }
        self.windows.deinit();
        self.* = undefined;
    }
};

test "should include no windows on init" {
    var app = App.init(std.testing.allocator);
    defer app.deinit();

    try std.testing.expect(app.windows.count() == 0);
}

test "should use next_window_id as window ID and increment next_window_id on window open" {
    var app = App.init(std.testing.allocator);
    defer app.deinit();
    const new_window = try app.open_window(window.WindowParams{});

    try std.testing.expect(new_window.id == 1);
    try std.testing.expect(app.windows.count() == 1);
    try std.testing.expect(app.next_window_id == 2);
}
