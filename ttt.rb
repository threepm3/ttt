# Representation of a 3 x 3 board
class Board
  attr_accessor :surface

  def initialize()
    @surface = Array.new(3) { Array.new(3) }
  end
  
#  def make_meta
#    @surface = Array.new(3) { Array.new(3) { Board.new() } }
#  end

  def update(x, y, char)
    surface[y][x] = char if surface[y][x].nil?
  end
  
  # returns char representing winner or nil if no winner
  def winner
    win_scenarios.each { |array| return array[0] if elements_match?(array) }
    nil
  end

  # returns true if every possible win scenario
  def draw?
    win_scenarios.each { |array| return false if !elements_mixed?(array) } 
    true
  end

  def to_s
    return_string = ""
    surface.each { |row| return_string += ("     " + row.to_s + "\n\n") }
    return_string
  end

  def prepare_test
    (0..2).each { |y|
      (0..2).each { |x|
        update(x, y, x+y)
      }
    }
  end

  # using surface attr_accessor doesn't work...
  def reset
    @surface = Array.new(3) { Array.new(3) }
  end

  private

    def elements_match?(array)    
      array.uniq.length == 1
    end

    def elements_mixed?(array)
      array.uniq.compact.length > 1
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
    @players = []
    @turn = random_turn
    @move = {}
    welcome
    get_players
    start
  end

  def start
    puts board
    while @board.winner.nil? && !@board.draw? do
      get_move
      fulfill_move
      puts board
      reverse_turn
    end
    if @board.draw?
      puts "That's a draw folks."
      @turn = random_turn
    else
      puts @board.winner + " wins! ..."
      @turn = player_index(@board.winner)
    end
    pause
    conclude
  end

  private

    def pause 
      puts "(Press ENTER.)"
      a_pause = gets
    end

    def welcome 
      newline
      puts "Welcome to ..."
      newline
      puts "        TTTTTTT   TTTTTTT    TTTTTTT     "
      puts "        TTTTTTT   TTTTTTT    TTTTTTT     "
      puts "          TTT       TTT        TTT       "
      puts "          TTT       TTT        TTT       "
      puts "          TTT  ic   TTT  ac    TTT oe    "
      newline
      puts "                       by Michael Prouty "
      newline
    end

    def conclude
      if play_again? 
        @board.reset
        start
      else
        puts "Goodbye!"
      end
    end
      
    def play_again?
      answer = nil
      permitted = ['y', 'n']
      while answer == nil do
        puts "Play again? [y/n]"
        buffer = gets[0]
        answer = buffer if permitted.include?(buffer)
      end
      return false if answer == 'n'
      return true if answer == 'y'
    end
      
    def get_players
      message =  "Player 1, select a character.  (e.g. '&', 'P', '2')"
      prohibited = ["\n"]
      player1 = get_player(message, prohibited) 

      message = "Player 2, select a DIFFERENT character."
      prohibited.push(player1)
      player2 = get_player(message, prohibited)
      @players = [player1, player2]
      puts "Pleased to meet you.  Let's play!"
      pause
    end

    def get_player(message, prohibited)
      player = nil
      while player == nil do
        puts message
        buffer = gets[0]
        player = buffer unless prohibited.include?(buffer)
        newline
      end
      player
    end

    
    def random_turn
      [0, 1].sample
    end

    def reverse_turn
      @turn = (@turn + 1) % 2
    end

    def player_index(player)
      players.index(player)
    end

    def fulfill_move
      while board.update(move[:x], move[:y], players[turn]).nil? do
        puts board
        puts "That spot is ALREADY TAKEN!" 
        pause
        get_move
      end
   end

    def get_move
      puts "Move for #{players[turn]}..."
      newline
      move[:x] = get_coordinate('x').to_i
      move[:y] = get_coordinate('y').to_i 
    end

    def get_coordinate(axis)
      permitted = ['0', '1', '2']
      coordinate = nil
      while coordinate.nil? do
        puts "Enter #{axis}-coordinate BETWEEN 0-2."
        buffer = gets[0]
        newline
        if permitted.include?(buffer)
          coordinate = buffer
        end
      end
      coordinate
    end

    def newline
      puts "\n"
    end
end

game = GamePlay.new
