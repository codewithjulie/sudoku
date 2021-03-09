require './tile.rb'
require 'colorize'

class Board
    def initialize
        @grid = Array.new(9) {Array.new(9) {" "}}

    end

    def [](position)
        row, col = position
        @grid[row][col]
    end

    def []=(position, value)
        row, col = position
        @grid[row][col] = value
    end

    def load_puzzle(filename)
        file = File.open(filename)
        file_data = file.readlines .map(&:chomp)

        (0...9).each do |row|
            (0...9).each do |col|
                tile_value = file_data[row][col]
                pos = [row, col]
                if tile_value != "0"
                    self[pos] = Tile.new(tile_value, true)
                else
                    self[pos] = nil
                end
            end
        end
    end

    def render
        @grid.each do |row|
            print "|"
            row.each do |ele|
                if ele
                    print ele.value.colorize(ele.color)
                else
                    print " "
                end
                print "|"
            end
            puts
        end
    end

    def update_position(position, value)
        if valid_position?(position) && valid_value?(value)
            self[position] = Tile.new(value.to_s, false)
        else
            raise "position is not valid"
        end
        
    end

    def valid_position?(position)
        row, col = position
        if (row < 0 || row > 8) && (col < 0 || col > 8)
            return false
        elsif
            if self[position]
                return false if self[position].given
            end
        else
            true
        end
    end

    def valid_value?(value)
        return value.is_a?(Integer) && value >= 0 && value < 9
    end


    def solved?
        self.all_filled? && self.solved_rows? && self.solved_columns?
    end

    def grid_with_nums
        grid_num = []
        @grid.each do |row|
            grid_num << row.map do |tile| 
                if tile
                    tile.value
                else
                    nil
                end
            end
        end
        grid_num
    end

    def solved_rows?
        grid_num = self.grid_with_nums
        grid_num.all? do |row|
            row.uniq.length == 9
        end
    end

    def all_filled?
        @grid.all? do |row|
            row.all? {|el| el != nil}
        end
    end

    def solved_columns?

        transposed_grid = []
        (0...9).each do |col|
            new_row = []
            (0...9).each do |row|
                if @grid[row][col]
                    new_row <<  @grid[row][col].value
                else
                    new_row << nil
                end
            end
            transposed_grid << new_row
        end
        transposed_grid.all? do |row|
            row.uniq.length == 9
        end
    end

end

board = Board.new

board.load_puzzle('puzzles/sudoku1_solved.txt')

# board.render

# board.update_position([0, 0], 4)

board.render

puts board.solved?