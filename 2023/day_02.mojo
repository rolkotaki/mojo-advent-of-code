# https://adventofcode.com/2023/day/2

""" *** Puzzle 1 ***

To get information, once a bag has been loaded with cubes, the Elf will reach into the bag, grab a handful of random
cubes, show them to you, and then put them back in the bag. He'll do this a few times per game.

You play several games and record the information from each game (your puzzle input). Each game is listed with its ID
number (like the 11 in Game 11: ...) followed by a semicolon-separated list of subsets of cubes that were revealed from
the bag (like 3 red, 5 green, 4 blue).

For example, the record of a few games might look like this:

Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

In game 1, three sets of cubes are revealed from the bag (and then put back again). The first set is 3 blue cubes and
4 red cubes; the second set is 1 red cube, 2 green cubes, and 6 blue cubes; the third set is only 2 green cubes.

The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes,
13 green cubes, and 14 blue cubes?

In the example above, games 1, 2, and 5 would have been possible if the bag had been loaded with that configuration.
However, game 3 would have been impossible because at one point the Elf showed you 20 red cubes at once; similarly,
game 4 would also have been impossible because the Elf showed you 15 blue cubes at once. If you add up the IDs of the
games that would have been possible, you get 8.

Determine which games would have been possible if the bag had been loaded with only 12 red cubes, 13 green cubes, and
14 blue cubes. What is the sum of the IDs of those games?
"""

from collections.dict import Dict


fn solution_puzzle_1(read filename: String) raises:
    var GAME_CONFIG = Dict[String, Int]()
    # this is not supported at global level yet
    GAME_CONFIG['red'] = 12
    GAME_CONFIG['green'] = 13
    GAME_CONFIG['blue'] = 14

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
        var game_id: String = lines[i].split(':')[0].split(' ')[1]
        var games: List[String] = lines[i].split(':')[1].split(';')
        var possible: Bool = True
        # looping through every game, then every ball in every set of balls and we determine if the game is possible
        for game in range(len(games)):
            var set_of_balls: List[String] = str(games[game].strip()).split(', ')
            for ball in range(len(set_of_balls)):
                if int(set_of_balls[ball].split(' ')[0]) > GAME_CONFIG[set_of_balls[ball].split(' ')[1]]:
                    possible = False
                    break
            if not possible:
                break
        if possible:
            result += int(game_id)
    
    print("Solution for Puzzle 1:", result)


""" *** Puzzle 2 ***

As you continue your walk, the Elf poses a second question: in each game you played, what is the fewest number of cubes 
of each color that could have been in the bag to make the game possible?

Again consider the example games from earlier:

Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

In game 1, the game could have been played with as few as 4 red, 2 green, and 6 blue cubes. If any color had even one 
fewer cube, the game would have been impossible.
Game 2 could have been played with a minimum of 1 red, 3 green, and 4 blue cubes.
Game 3 must have been played with at least 20 red, 13 green, and 6 blue cubes.
Game 4 required at least 14 red, 3 green, and 15 blue cubes.
Game 5 needed no fewer than 6 red, 3 green, and 2 blue cubes in the bag.
The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together. The power of the 
minimum set of cubes in game 1 is 48. In games 2-5 it was 12, 1560, 630, and 36, respectively. Adding up these five 
powers produces the sum 2286.

For each game, find the minimum set of cubes that must have been present. What is the sum of the power of these sets?
"""

fn solution_puzzle_2(read filename: String) raises:
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
        var games: List[String] = lines[i].split(':')[1].split(';')
        var colors: Dict[String, Int] = Dict[String, Int]()
        colors['red'] = 0
        colors['green'] = 0
        colors['blue'] = 0

        # looping through every game, then every ball in every set of balls and we get the max number for each color
        for game in range(len(games)):
            var set_of_balls: List[String] = str(games[game].strip()).split(', ')
            for ball in range(len(set_of_balls)):
                var color: String = set_of_balls[ball].split(' ')[1]
                var num_of_cubes: Int = int(set_of_balls[ball].split(' ')[0])
                if num_of_cubes > colors[color]:
                    colors[color] = num_of_cubes
        
        # multiplying together the numbers of each color
        var power_of_set: Int = 1
        for e in colors.values():
            power_of_set *= e[].value
        # adding it to the result
        result += power_of_set
    
    print("Solution for Puzzle 2:", result)


fn main() raises:
    var filename: String = "2023/input/day_02.txt"
    solution_puzzle_1(filename)
    solution_puzzle_2(filename)


"""
Solution for Puzzle 1: 2085
Solution for Puzzle 2: 79315
"""

# Mojo version: 24.6.0
