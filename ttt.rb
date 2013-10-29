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
  attr_accessor :board, :player1_char, :player2_char
  def initialize(player1_char, player2)
    @board = Board.new
    @player1_char = player1_char
    @player2 = player2
  end

  def won?
    row_won? || column_won? || diagonal_won?
  end

  def row_winner
    player1_row = Array.new( 3, player1_char )
    player2_row = Array.new( 3, player2_char )
    
    board.surface.each do |row| 
      return player1_char if row == player1_row 
      return player2_char if row == player2_row
    end
  end

  # Alrogithm: start with [0][0], [1][0], [2][0]
  def column_won?
    (0..2).each
  end

  def diagonal_won?
  end

end

# Takes care of user interaction
class GamePlay
  def self.start()
    puts "Type a character to represent Player 1."
    player1_char = gets[0] 
    player2_char = nil
    while player2_char == nil do
      puts "Type a DIFFERENT character to represent Player 2."
      buffer = gets[0]
      player2_char = buffer unless (buffer == player1_char) 
    end
    board = Board.new
    puts board
    game = Game.new(board, player1_char, player2_char)
    puts game
  end 

end

