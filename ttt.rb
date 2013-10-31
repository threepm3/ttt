# Representation of a 3 x 3 board
class Board
  attr_accessor :surface

  def initialize()
    @surface = Array.new(3) { Array.new(3) }
  end

  def update(x, y, char)
    surface[y][x] = char if surface[y][x].nil?
  end
  
  # returns char representing winner or nil if no winner
  def winner
    win_scenarios.each { |array| return array[0] if elements_match?(array) }
    nil
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

  private

    def elements_match?(array)    
      array.uniq.length == 1
    end

    # returns an array of 3-element arrays based on each win condition
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

end  

# Takes care of user interaction
class GamePlay
  attr_accessor :board, :players, :turn, :move

  def initialize()
    @board = Board.new
    @players = get_players
    @turn = random_turn
    @move = {}
  end

  def start
    puts board
    while @board.winner.nil? do
      get_move
      while board.update(move[:x], move[:y], players[turn]).nil? do
        puts board
        puts "That spot is already taken." 
        get_move
      end
      puts board
      reverse_turn
    end
    puts @board.winner + "Wins!"
  end

  # private

    def get_players
      puts "Player 1, select a character."
      player1 = gets[0] 
      player2 = nil
      while player2 == nil do
        puts "Player 2, select a DIFFERENT character."
        buffer = gets[0]
        player2 = buffer unless (buffer == player1) 
      end
      [player1, player2]
    end
    
    def random_turn
      [0, 1].sample
    end

    def reverse_turn
      @turn = (@turn + 1) % 2
    end

    def get_move
      puts "Move for #{players[turn]}..."
      move[:x] = get_coordinate('x').to_i
      move[:y] = get_coordinate('y').to_i 
    end

    def get_coordinate(axis)
      permitted = ['0', '1', '2']
      coordinate = nil
      while coordinate.nil? do
        puts "Enter #{axis}-coordinate BETWEEN 0-2."
        buffer = gets[0]
        if permitted.include?(buffer)
          coordinate = buffer
        end
      end
      coordinate
    end
end
