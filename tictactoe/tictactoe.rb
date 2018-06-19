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
    (1..9).each {|key| @squares[key] = Square.new}
    #Each value in the hash key is a Square objectand each object is initialized with a marker
    #that  can be retrieved. Right now, the object just has a marker

  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
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

  #returns winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line| #the line will be the set of arrays in the nested array
      #in each row of the nested array line, look to see if elements in that line have the same marker
      #eg [first element in line is [1,2,3,], so see if 1 and 2 and 3 have same marker
      if @squares[line[0]].marker == TTTGame::HUMAN_MARKER &&
        @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
        @squares[line[2]].marker == TTTGame::HUMAN_MARKER
        return TTTGame::HUMAN_MARKER
      elsif @squares[line[0]].marker ==TTTGame::COMPUTER_MARKER &&
        @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
        @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
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


    board.set_square_at(square, human.marker)#square is wat number and is captured in square local variable
    #human.marker has a :human in TTTgame class to access human object and :marker in Player class
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker) #computer is a player object, and it has :marker
  end


  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    system 'clear' #to get rid of outputs to clear up screen
    puts "You're a #{HUMAN_MARKER} and computer is a #{COMPUTER_MARKER}"
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def display_result
    display_board

    case board.detect_winner #returns winning marker whihc is a string or nil
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!!"
    end
  end


  def play
    display_welcome_message
    display_board
    loop do
      human_moves
      break if board.full? || board.someone_won?
      computer_moves
      break if board.full? || board.someone_won?
      display_board
      #break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play



