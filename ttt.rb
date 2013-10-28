# Representation of a 3 x 3 board
# Moves: nil for blank, 1 for player1, 2 for player2
class Board
  attr_accessor :surface

  def initialize()
    @surface = Array.new(3) { Array.new(3) }
  end

  def to_s
    return_string = ""
    surface.each { |row| return_string += (row.to_s + "\n") }
    return_string
  end

end

# 
class Game
  def initialize(board, player1, player2)
    @game_board = board
    @player1 = player1
    @player2 = player2
  end
end

class Player 
  
end

class Move
end
