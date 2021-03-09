class Tile

    attr_accessor :value, :color, :given

    def initialize(value, given)
        @value = value
        @given = given
        @color = :red if @given == true
        @color = :white if @given == false
        
    end

    def to_s
        puts "This tile is #{@value} and it is #{@color}"
    end
end