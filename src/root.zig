const std = @import("std");
const print = std.debug.print;

pub fn get_input(allocator: std.mem.Allocator, day: usize) ![]u8{
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var client = std.http.Client{ .allocator = gpa.allocator()};
    defer client.deinit();
    
    const url_template = "https://adventofcode.com/2025/day/{d}/input";
    var buffer_url: [50]u8 = undefined;
    const formatted = try std.fmt.bufPrint(&buffer_url, url_template, .{day});

    const uri = try std.Uri.parse(formatted);
    
    // Read session Cookie
    var buffer: [1024]u8 = undefined;
    const session_cookie = try std.fs.cwd().readFile(".session", &buffer);
    var buffer_cookie: [1024]u8 = undefined;
    const cookie_string = try std.fmt.bufPrint(&buffer_cookie, "session={s}", .{session_cookie});

    // Prepare headers
    const headers = [_]std.http.Header{.{.name = "Cookie", .value = cookie_string}};

    // Body of the answer
    var result_body = std.Io.Writer.Allocating.init(allocator);
    defer result_body.deinit();


    // Create request with headers
    const response = try client.fetch(.{
        .location = .{.uri = uri},  
        .response_writer = &result_body.writer,
        .method = .GET,
        .extra_headers = &headers,
    });

    if (response.status.class() == .success) {
        return result_body.toOwnedSlice();
    } else {
        @panic("request failed");
    }
}


test "check connection" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const input_day01 = try get_input(allocator, 1);
    defer allocator.free(input_day01);
    // print("Input day 1: {s}", .{input_day01});
}
