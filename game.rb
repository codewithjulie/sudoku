require './board.rb'

# Create new board
board = Board.new

# Load puzzle onto the board
board.load_puzzle('puzzles/sudoku1_almost.txt')

# Render the board
board.render

while !board.solved?
    # clear the board
    system("clear")
    # Render the board
    board.render
    # ask user to update_position
    puts "Where do you want to mark the board? ex: '3 4'"
    position = gets.split(" ")
    
    while !board.valid_position?(position)
        puts "That was an invalid position, please choose a number between 0 and 8"
        puts "Where do you want to mark the board? ex: '3 4'"
        position = gets.split(" ")
    end

    # ask for position
    puts "What value do you want to put here?"
    # ask for value
    value = gets.chomp
    # if either are invalid, repeat

    while !board.valid_value?(value)
        puts "That was an invalid value, please choose a number between 1 and 9"
        puts "What value do you want to put here?"
        value = gets.chomp
    end

    # once valid - update the position
    board.update_position(position, value)
end
system("clear")
board.render
puts "Congratulations! You solved the puzzle!"