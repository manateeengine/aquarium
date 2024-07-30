/// An application Window
pub const Window = struct {
    id: u32,
    params: WindowParams,
    pub fn init(id: u32, params: WindowParams) Window {
        // TODO: Implement system window params
        return Window{
            .id = id,
            .params = params,
        };
    }

    pub fn deinit(self: *Window) void {
        self.* = undefined;
    }
};

pub const WindowParams = struct {
    comptime title: []const u8 = "Aquarium Window",
};
