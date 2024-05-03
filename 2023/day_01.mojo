# https://adventofcode.com/2023/day/1

""" *** Puzzle 1 ***

The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration
value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit
and the last digit (in that order) to form a single two-digit number.

For example:
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.
"""

alias DIGIT_LIST: String = '123456789'


fn solution_puzzle_1(filename: String) raises:
    var result: Int = 0
    var file_content: String = String()
    # reading the file
    with open(filename, 'r') as f:
        file_content = f.read()
    var lines: List[String] = file_content.split('\n')
    # looping through the lines in the file
    for i in range(len(lines)):
        if lines[i].strip() == '':
            continue
        var digits: List[String] = List[String]()
        for j in range(len(lines[i])):
            if DIGIT_LIST.count(lines[i][j]) > 0:
                digits.append(lines[i][j])
        # get the first and last digit in the line and add it to the result
        result += int(digits[0] + digits[len(digits)-1])
    
    print("Solution for Puzzle 1:", result)


""" *** Puzzle 2 ***

Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, 
three, four, five, six, seven, eight, and nine also count as valid "digits".
Equipped with this new information, you now need to find the real first and last digit on each line.

For example:
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
In this example, the calibration values are 29, 83, 13, 24, 42, 14, and 76. Adding these together produces 281.
"""

fn solution_puzzle_2(filename: String) raises:
    var DIGIT_WORD_MAPPING = Dict[String, String]()
    # this is not supported at global level yet
    DIGIT_WORD_MAPPING['1'] = 'one'
    DIGIT_WORD_MAPPING['2'] = 'two'
    DIGIT_WORD_MAPPING['3'] = 'three'
    DIGIT_WORD_MAPPING['4'] = 'four'
    DIGIT_WORD_MAPPING['5'] = 'five'
    DIGIT_WORD_MAPPING['6'] = 'six'
    DIGIT_WORD_MAPPING['7'] = 'seven'
    DIGIT_WORD_MAPPING['8'] = 'eight'
    DIGIT_WORD_MAPPING['9'] = 'nine'

    var result: Int = 0
    var file_content: String = String()

    # reading the file
    with open(filename, 'r') as f:
        file_content = f.read()
    var lines: List[String] = file_content.split('\n')

    # looping through the lines in the file
    for i in range(len(lines)):
        if lines[i].strip() == '':
            continue

        var left_digit: String = String()
        var right_digit: String = String()
        var left_min_index: Int16 = 999
        var right_max_index: Int16 = -1
        var cur_index: Int16 = Int16()
        var line: String = lines[i]
        
        # replacing the digits to the words
        for e in DIGIT_WORD_MAPPING.items():
            line = line.replace(e[].key, e[].value)
        # finding the word (of a digit) with the min and max index, meaning the first and last digit
        for e in DIGIT_WORD_MAPPING.items():
            cur_index = line.find(e[].value)
            if cur_index != -1 and cur_index < left_min_index:
                left_min_index = cur_index
                left_digit = e[].key
            cur_index = line.rfind(e[].value)
            if cur_index != -1 and cur_index > right_max_index:
                right_max_index = cur_index
                right_digit = e[].key
        # get the first and last digit in the line and add it to the result
        result += int(left_digit + right_digit)
    
    print("Solution for Puzzle 2:", result)


fn main() raises:
    var filename: String = "2023/input/day_01.txt"
    solution_puzzle_1(filename)
    solution_puzzle_2(filename)


"""
Solution for Puzzle 1: 55130
Solution for Puzzle 2: 54985
"""
