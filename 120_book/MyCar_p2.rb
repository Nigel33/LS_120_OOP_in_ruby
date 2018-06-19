class MyCar
  attr_accessor :color, :year, :model
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def self.calculate_gas_mileage(miles, gallon)
    puts "The car mileage is #{miles/gallon} miles per gallon"         
  end
              
  
  def speed_up(number)
    @current_speed += number
  end
  
  def display_speed
    puts "You are moving at #{@current_speed} mph"
  end
  
  def brake(number)
    @current_speed -= number 
  end
  
  def turn_off
    @current_speed = 0
    puts "Let's turn the car off"
  end
  
  def spray_paint(color) 
    puts "Lets spray paint this baby in #{color}"
    self.color = color
  end
  
  def to_s
    "This car is #{year} years old, #{color} and #{model} model"
  end
  
end

car = MyCar.new(1957, 'white', 'lumina')
MyCar.calculate_gas_mileage(52,2)
puts car 
