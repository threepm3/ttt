# Representation of a 3 x 3 board
# Moves: nil for blank, 1 for player1, 2 for player2
class Board
  attr_accessor :surface

  def initialize()
    @surface = Array.new(3) { Array.new(3) }
  end

  def to_s
    surface.each do |row|
      puts row
    end
  end

end

# 
class Game
end

class Player 
end

class Move
end
