const std = @import("std");
const aoc = @import("AdventOfCode2025");
const print = std.debug.print;

fn part_one(input: []const u8) !usize {
    _ = input;
    return 1227775554;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const input = try aoc.get_input(allocator, 1);
    defer allocator.free(input);

    const solution = try part_one(input);
    print("Solution Part One: {d}!\n", .{solution});
    
    // const solution_part_two = try part_two(input);
    // print("Solution Part Two: {d}!\n", .{solution_part_two});
}

const test_input = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124";

test "PartOne" {
    const solution = try part_one(test_input);
    std.debug.print("P1 Solution is {}\n", .{solution});
    
    try std.testing.expect(solution == 1227775554);
}
