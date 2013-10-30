# Representation of a 3 x 3 board
class Board
  attr_accessor :surface

  def initialize()
    @surface = Array.new(3) { Array.new(3) }
  end

  def update(x, y, char)
    surface[y][x] = char
  end
  
  # returns char representing winner or nil if no winner
  def winner
    win_scenarios.each { |array| return array[0] if elements_match?(array) }
    nil
  end

  def elements_match?(array)    
    array.uniq.length == 1
  end

  # creates an array of 3-element arrays based on each win condition
  def win_scenarios()
    win_scenarios = []

    # add rows and columns 
    (0..2).each do |i|
      win_scenarios.push(row(i))
      win_scenarios.push(column(i))
    end

    # add diagonals
    win_scenarios.push(diagonal)
    win_scenarios.push(reverse_diagonal)

    # return
    win_scenarios
  end

  def column(i)
    column = []
    surface.each { |row| column.push(row[i]) } 
    column
  end

  def row(i)
    surface[i]
  end

  def diagonal()
    diagonal = []
    (0..2).each do |i|
      diagonal.push(surface[i][i])
    end
    diagonal
  end

  def reverse_diagonal()
    reverse_diagonal = []
    (0..2).each do |i|
      reverse_diagonal.push(surface[i][-(i+1)])
    end
    reverse_diagonal
  end

  def to_s
    return_string = ""
    surface.each { |row| return_string += (row.to_s + "\n") }
    return_string
  end

  def prepare_test
    (0..2).each { |y|
      (0..2).each { |x|
        update(x, y, x+y)
      }
    }
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

  def to_s
    @board.to_s
  end

end

# Takes care of user interaction
# All class methods, b/c we don't want multiple simultaneous games
class GamePlay
  def self.start()
    self.setup()
    while 
  end 

  def self.setup()
    puts "Player 1, select a character."
    player1_char = gets[0] 
    player2_char = nil
    while player2_char == nil do
      puts "Player 2, select a DIFFERENT character."
      buffer = gets[0]
      player2_char = buffer unless (buffer == player1_char) 
    end
    @@game = Game.new(player1_char, player2_char)
  end

end

