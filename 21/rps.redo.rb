require 'pry'

class Player
  MOVE_LIST = %w(rock paper scissors)
  attr_accessor :name, :move, :type

  def initialize(name, type)
    @name = name
    @type = type
  end

  def answer_valid?(answer)
    answer.downcase.start_with?('r', 'p', 's')
  end

  def choose
    response = nil
    if type == :human
      loop do
        puts "Please choose either #{MOVE_LIST.join(' ,')}"
        response = gets.chomp
        break if answer_valid?(response)
        puts 'This move is invalid, please choose again'
      end
      self.move = Move.new(response) #if creating a new class
    #self.move = response if using states in Player class
    elsif type == :computer
      self.move = Move.new(MOVE_LIST.sample)
    end
  end

end

class Move
  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def rock?
    @value == 'rock'
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    case @value
    when 'rock'
      return true if other_move.scissors?
    when 'scissors'
      return true if other_move.paper?
    when 'paper'
      return true if other_move.rock?
    end
    nil
  end

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new("Bob", :human)
    @computer = Player.new("Hal", :computer)
  end

  def display_welcome_message
    puts "Welcome to rock paper scissors!"
  end

  def display_winner
    puts "You chose #{human.move} and computer chose #{computer.move}"
    if human.move > computer.move
      puts "You won!"
    elsif computer.move > human.move
      puts "Computer won!"
    else
      puts "its a Tie!"
    end
  end

  def display_goodbye_message
    puts "Thank you for playing!"
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play