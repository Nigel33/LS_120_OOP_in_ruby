class Score
  WINNING_SCORE = 3

  def initialize(value)
    @value = value
  end

  def increment
    @value += 1
  end

  def to_s
    @value.to_s
  end

  def ==(score)
    @value == score
  end
end

class Move
  VALUES = ["paper", "rock", "scissors"].freeze

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts 'Whats your name?'
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value'
    end
    self.name = n
  end

  def set_score
    self.score = Score.new(0)
  end

  def choose
    choice = ''
    loop do
      puts 'Please choose rock, paper, or scissors:'
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(R2D2 Hal Android).sample
  end

  def set_score
    self.score = Score.new(0)
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    # mv = ['rock', 'paper', 'scissors'].sample
    # self.move = Move.new(mv)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors. Good bye!'
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      human.score.increment
      puts "#{human.name} won!"
    elsif human.move < computer.move
      computer.score.increment
      puts "#{computer.name} won!"
    else
      puts 'Its a tie!'
    end
    puts "#{human.name}'s score is #{human.score} \n" +
         "#{computer.name}'s score is #{computer.score}"
    puts "-----------------------------------------------"
  end

  def display_overall_winner
    if human.score == Score::WINNING_SCORE
      puts "#{human.name} is the overall winner!"
    elsif computer.score == Score::WINNING_SCORE
      puts "#{computer.name} is the overrall winner!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again (y/n)'
      answer = gets.chomp
      break if %w(y n).include?(answer.downcase)
      puts 'Sorry, must be y or n'
    end

    return true if answer == 'y'
    return false if answer == 'n'
  end

  def play
    display_welcome_message
    loop do
      human.set_score
      computer.set_score
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        break if human.score == Score::WINNING_SCORE ||
          computer.score == Score::WINNING_SCORE
      end
      display_overall_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

#----------------------------------------------------
RPSGame.new.play