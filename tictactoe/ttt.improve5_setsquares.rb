#TicTaxToe is a 2 player board game played  on a 3*3 grid. Players take turn marking a quare. First player to mark 3 squarezs win

#nouns; Board, player, square, grid
#verbs play , mark

#Board
#Square
#Players-
  #mark
  #play
require 'pry'
class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9]] + #rows
                [[1,4,7], [2,5,8], [3,6,9]] + #cols
                [[1,5,9], [3,5,7]] #diagonals

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |"
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
    #Each value in the hash key is a Square objectand each object is initialized with a marker
    #that  can be retrieved. Right now, the object just has a marker

  end

  def get_square_at(key)
    @squares[key]
  end

  def []=(num, marker)
    @squares[num].marker = marker
    #@squares[key] is a Square object so .marker= as a setter method to set is with nre marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked? }
    #@squares is hash, calling keys on it returns an array of integers
    # @returns the integers adn from those integers, select @squares[key] which is
    # an object and see if its unmarked. Sinc calling from Squares object must create
    # unmarked method in Square
  end

  def full?
    unmarked_keys.empty? #if its empty which means no unmarked suqares, then the board is full
  end

  #relies in detect_winner method. If returns a truuthy value,
  #!! will retturn true if detect_winner is truthy or false if falsey
  def someone_won?
    !!detect_winner
  end

  def count_human_marker(squares)#gives us array of square objects
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
    #call marker on every single element of array square objects
    #which is array of markers and which is array of string
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  #returns winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line| #each line is array of [1,2,3] or [4,5,6]
      #values_at returns value of the key. In first iterstion, We want to return
      #values of first line [1,2,3]. So we want @squares.values_at(1,2,3). However, line
      #is [1,2,3]. SO we use *operator to turin it into parameters that we can feed
      #into values_at
      if count_human_marker(@squares.values_at(*line)) == 3 #use values to return an array, otherwise will return hash
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end
  #needs nil otherwise will return winning_lines if both if conditions fail

end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker #for the @squares[key].marker method since its an object

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end


end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def play

  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'

  attr_reader :board, :human, :computer

  def initialize
     @board = Board.new
     @human = Player.new(HUMAN_MARKER)
     @computer = Player.new(COMPUTER_MARKER)
  end

  def human_moves
    puts "Choose a square between #{board.unmarked_keys.join (', ')}: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end


    board[square] = human.marker #square is wat number and is captured in square local variable
    #human.marker has a :human in TTTgame class to access human object and :marker in Player class
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker #computer is a player object, and it has :marker
  end


  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{HUMAN_MARKER} and computer is a #{COMPUTER_MARKER}"
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board #will clear by default, but if pass in false, then wont clear
    clear #to get rid of outputs to clear up screen
    display_board
  end

  def display_result
    clear_screen_and_display_board
    case board.detect_winner #returns winning marker whihc is a string or nil
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
    end
    answer == 'y'
    #if answer != 'y', will return false
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end


  def play
    display_welcome_message
    clear
    loop do
      #displaty board has clear the screen code
      display_board
      loop do
        human_moves
        break if board.full? || board.someone_won?
        computer_moves
        break if board.full? || board.someone_won?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
      end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play



