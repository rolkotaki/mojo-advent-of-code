# https://adventofcode.com/2023/day/3

""" *** Puzzle 1 ***

The engineer explains that an engine part seems to be missing from the engine, but nobody can figure out which one.
If you can add up all the part numbers in the engine schematic, it should be easy to work out which part is missing.

The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of numbers
and symbols you don't really understand, but apparently any number adjacent to a symbol, even diagonally, is a
"part number" and should be included in your sum. (Periods (.) do not count as a symbol.)

Here is an example engine schematic:
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
In this schematic, two numbers are not part numbers because they are not adjacent to a symbol: 114 (top right) and
58 (middle right). Every other number is adjacent to a symbol and so is a part number; their sum is 4361.

Of course, the actual engine schematic is much larger. What is the sum of all of the part numbers in the engine
schematic?
"""

alias DIGIT_LIST: String = '0123456789'


fn solution_puzzle_1(borrowed filename: String) raises:
    var result: Int = 0
    var file_content: String = String('')
    # reading the file
    with open(filename, 'r') as f:
        file_content = f.read()
    var lines: List[String] = file_content.strip().split('\n')

    var number: String = String('')
    var number_coordinates: List[StaticIntTuple[2]] = List[StaticIntTuple[2]]()
    var is_part_number: Bool = False

    # looping through the lines in the file
    for i in range(len(lines)):
        # looping through every character in the line
        for c in range(len(lines[i])):
            if DIGIT_LIST.count(lines[i][c]) > 0:
                number += lines[i][c]
                number_coordinates.append((i, c))
            if DIGIT_LIST.count(lines[i][c]) == 0 or c == len(lines[i]) - 1:
                is_part_number = False
                if number != '':
                    for number_coordinate in number_coordinates:
                        for x in range(-1 if i > 0 else 0, 2 if i < len(lines)-1 else 1):
                            for y in range(-1 if c > 0 else 0, 2 if c < len(lines[i])-1 else 1):
                                if not(x == 0 and y == 0) and (DIGIT_LIST + '.').count(lines[number_coordinate[][0] + x][number_coordinate[][1] + y]) == 0:
                                    result += int(number)
                                    is_part_number = True
                                    break
                            if is_part_number:
                                break
                        if is_part_number:
                            break 
                number = ''
                number_coordinates.clear()
        
        
    print("Solution for Puzzle 1:", result)


""" *** Puzzle 2 ***

The missing part wasn't the only issue - one of the gears in the engine is wrong. A gear is any * symbol that is 
adjacent to exactly two part numbers. Its gear ratio is the result of multiplying those two numbers together.

This time, you need to find the gear ratio of every gear and add them all up so that the engineer can figure out which 
gear needs to be replaced.

Consider the same engine schematic again:
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
In this schematic, there are two gears. The first is in the top left; it has part numbers 467 and 35, so its gear ratio 
is 16345. The second gear is in the lower right; its gear ratio is 451490. (The * adjacent to 617 is not a gear because 
it is only adjacent to one part number.) Adding up all of the gear ratios produces 467835.

What is the sum of all of the gear ratios in your engine schematic?
"""

fn solution_puzzle_2(borrowed filename: String) raises:
    var result: Int = 0
    var file_content: String = String('')
    # reading the file
    with open(filename, 'r') as f:
        file_content = f.read()
    var lines: List[String] = file_content.strip().split('\n')

    var coordinates_of_numbers: Dict[String, Int] = Dict[String, Int]()
    var number: String = String('')
    var current_number_columns: List[Int] = List[Int]()
    var gear_part_numbers: List[Int] = List[Int]()

    # looping through the lines in the file to find all the part numbers
    for i in range(len(lines)):
        # looping through every character in the line
        for c in range(len(lines[i])):
            if DIGIT_LIST.count(lines[i][c]) > 0:
                number += lines[i][c]
                current_number_columns.append(c)
            if DIGIT_LIST.count(lines[i][c]) == 0 or c == len(lines[i]) - 1:
                if number != '':
                    for number_coordinate in current_number_columns:
                        # adding the "row:column" coordinate as the key and the number as the value to the dictionary
                        coordinates_of_numbers[str(i) + ':' + str(number_coordinate[])] = int(number)
                number = ''
                current_number_columns.clear()
        
    # looping through the lines in the file to find all the starts (*) and check if it has exactly two part numbers
    # (or we could use the previous loop and check for the stars in the line i - 1)
    for i in range(len(lines)):
        # looping through every character in the line
        for c in range(len(lines[i])):
            if lines[i][c] == '*':
                for row_diff in range(-1, 2):
                    if row_diff != 0:
                        # if the character right above or below the * is a number, 
                        # then we can be sure that is the only part number above the or below the *
                        if DIGIT_LIST.count(lines[i + row_diff][c]) > 0:
                            gear_part_numbers.append(coordinates_of_numbers[str(i + row_diff) + ':' + str(c)])
                            continue
                    for col_diff in range(-1, 2, 2):
                        if row_diff == 0 and col_diff == 0:
                            # this is the * itself
                            continue
                        if DIGIT_LIST.count(lines[i + row_diff][c + col_diff]) > 0:
                            gear_part_numbers.append(coordinates_of_numbers[str(i + row_diff) + ':' + str(c + col_diff)])
                        if len(gear_part_numbers) > 2:
                            break
                    if len(gear_part_numbers) > 2:  
                        break
                # if the gear has exactly two part numbers
                if len(gear_part_numbers) == 2:
                    result += gear_part_numbers[0] * gear_part_numbers[1]
                gear_part_numbers.clear()
    
    print("Solution for Puzzle 2:", result)


fn main() raises:
    var filename: String = "2023/input/day_03.txt"
    solution_puzzle_1(filename)
    solution_puzzle_2(filename)


"""
Solution for Puzzle 1: 539637
Solution for Puzzle 2: 82818007
"""

# Mojo version: 24.4.0
