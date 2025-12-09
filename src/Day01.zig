const std = @import("std");
const aoc = @import("AdventOfCode2025");
const print = std.debug.print;

fn part_one(input: []const u8) !usize {
    var pos: isize = 50;
    var counter: usize = 0;
    var iterator = std.mem.splitScalar(u8, input, '\n');

    while (iterator.next()) |line| {
        if (line.len == 0) continue;

        const sign: i8 = switch (line[0]){
            'L' => 1,
            'R' => -1,
            else => {
                @panic("Invalid Input");
            }
        };
        const len = try std.fmt.parseInt(i32, line[1..], 10);
        pos += sign*len;
        pos = @mod(pos, 100);

        if (pos == 0) {
            counter += 1;
        }
    }

    return counter;
}


fn part_two(input: []const u8) !usize {
    var pos: isize = 50;
    var counter: usize = 0;
    var iterator = std.mem.splitScalar(u8, input, '\n');


    while (iterator.next()) |line| {
        if (line.len == 0) continue;

        const sign: i8 = switch (line[0]){
            'L' => -1,
            'R' => 1,
            else => {
                unreachable;
            }
        };
        const len = try std.fmt.parseInt(i32, line[1..], 10);

        const start_at_zero = pos == 0;

        pos += sign*len;
        counter += @abs(@divFloor(pos, 100));
        pos = @mod(pos, 100);

        if (sign < 0){
            if (start_at_zero)
                counter -= 1;
            
            if (pos == 0)
                counter +=1;
        }

    }

    return counter;
}


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const input = try aoc.get_input(allocator, 1);
    defer allocator.free(input);

    const solution = try part_one(input);
    print("Solution Part One: {d}!\n", .{solution});
    
    const solution_part_two = try part_two(input);
    print("Solution Part Two: {d}!\n", .{solution_part_two});
}

const test_input = 
        \\L68
        \\L30
        \\R48
        \\L5
        \\R60
        \\L55
        \\L1
        \\L99
        \\R14
        \\L82
    ;

test "PartOne" {
    const solution = try part_one(test_input);
    std.debug.print("P1 Solution is {}\n", .{solution});
    
    try std.testing.expect(solution == 3);
}

test "PartTwo" {
    const solution = try part_two(test_input);
    std.debug.print("P2 Solution is {}\n", .{solution});
    
    try std.testing.expect(solution == 6);
}
