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

  def update(x, y, char)
    @surface[y][x] = char
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
  attr_accessor :name, :mark

  def initialize(name, mark)
    @name = options[name]
    @mark = options[mark]
  end

  def get_user_input()
    #ask for x coordinate
    #ask for y coordinate
    #return [x, y]
    [0,0]
  end 

  def make_move()
    update_board(self, get_user_input())
  end

end

