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
  attr_accessor :board, :player1, :player1, :turn_index, :move
  def start()
    setup()
    while @board.winner.nil? do
      puts @board
      get_move(@current_player)
    end
      
  end

  private

    def setup()
      puts "Player 1, select a character."
      player1 = gets[0] 
      player2 = nil
      while player2 == nil do
        puts "Player 2, select a DIFFERENT character."
        buffer = gets[0]
        player2 = buffer unless (buffer == player1) 
      end
      @board = Board.new
      @players = [player1, player2]
      random_turn_index
    end
    
    def random_turn_index()
      @turn_index = [1, -1].sample
    end

    def end_turn
      turn_index *= -1
      move = nil
    end

    def move()
      puts "Move for #{players[@turn_index]}..."
      permitted = ['0', '1', '2']

      while @move_x = nil do
        puts "Enter x-coordinate BETWEEN 0-2."
        buffer = gets[0]
        if permitted.include?(buffer)
          @move_x = gets[0]
        end
      end


        puts "Enter y-coordinate between 0-2."
        @movey = gets[0]
      end
    end
end
