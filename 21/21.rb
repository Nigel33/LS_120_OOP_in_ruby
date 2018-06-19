
require 'pry'

class Participant
  NUMBER = {"Jack" => 10, "Queen" => 10, "King" => 10, "Ace" => 11}.freeze

  attr_accessor :card, :type

  def initialize(type)
    @card = []
    @type = type
  end

  def show_cards
    puts card.to_s
  end

  def prompt
    puts "Do you want to hit(h) or stay(s)?"
  end

  def turn(cards)
    if type == "Player"
      response = nil
      loop do
        prompt
        response = gets.chomp.downcase
        loop do
          if response.start_with?('h') || response.start_with?('s')
            break
          elsif
            puts "Sorry, invalid move. Please try again"
          end
        end

        if response.start_with?('h')
          hit(cards)
          sequence
          break if bust?
        else
          stay
          sequence
          break
        end
      end

    elsif type == "Dealer"
      puts "Its Dealer's turn.."
      show
      while get_total < 17
        puts "Hit anything to continue"
        response = gets.chomp
        hit(cards)
        sequence
        break if bust?
      end

    end

  end

  def hit(cards)
    puts "Hitting.."
    card << cards.to_s.pop
  end

  def stay
    puts "Staying.."
  end


  def show
    puts '-------------------------------'
    puts "#{type} has.."
    card.each do |hash|
      hash.each do |suit, value|
        puts "#{suit} : #{value}"
      end
    end
    puts "-------------------------------"
  end

  def get_total
    array = []
    sum = 0
    card.each do |hash|
      hash.each do |_,value|
        array << value
      end
    end
    array_sum = array.map do |value|
      if NUMBER.has_key?(value)
        NUMBER[value]
      else
        value
      end
    end
    sum = array_sum.reduce(:+)

    if sum > 21 && array.include?("Ace")
      return update_ace_value(sum)
    end

    sum
  end

  def sequence
    show
    get_total
    display_total
  end

  def display_total
    puts "#{type} total is #{get_total}"
  end

  def update_ace_value(ace)
    (ace - 10)
  end

  def bust?
    if get_total > 21
      puts "Busted!"
      return true
    end
    nil
  end

  def to_s
    @card
  end



end

class Player < Participant

  def initialize(type)
    super
  end

  def show_initial
    show
  end
end



class Dealer < Participant
  def initialize(type)
    super
  end

  def shuffle_cards(cards)
    cards.to_s.shuffle!
  end

  def deal(cards,person)
    2.times do
      self.card << cards.to_s.pop
      person.card << cards.to_s.pop
    end
  end

  def parse(hash)
    puts '-------------------------------'
    hash.each do |suit,value|
      puts "#{suit} : #{value}"
    end
    puts "Unknown"
    puts '-------------------------------'
    puts ""
  end

  def show_initial
    puts "Dealer has.."
    parse(card.first)
  end
end

class Deck

  SUITS = [:Diamonds, :Clubs, :Hearts, :Spades]
  VALUES = [2,3,4,5,6,7,8,9,10, "Jack", "Queen", "King", "Ace"].freeze
  def initialize
    @deck = []
    hash = {}
    SUITS.each do |suit|
      VALUES.each do |value|
        hash[suit] = value
        @deck << hash
        hash = {}
      end
    end
  end

  def to_s
    @deck
  end
end

class Game
  attr_accessor :deck, :dealer, :player

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new("Dealer")
    @player = Player.new("Player")
  end

  def display_welcome_message
    puts "Welcome to 21!"
  end

  def display_result
    puts "Thank you for playing!"
  end

  def start
    display_welcome_message
    loop do
      dealer.shuffle_cards(deck)
      dealer.deal(deck, player)
      dealer.show_initial
      player.show_initial
      player.turn(deck)
      break if player.bust?
      dealer.turn(deck)
      break
    end
    display_result
  end
end

play = Game.new
play.start


