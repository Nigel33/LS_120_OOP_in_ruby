class MyCar
  
  attr_accessor :color
  attr_reader :year
  
  def initialize(year, model, color)
    @year = year
    @model = model 
    @color = color 
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph"
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph"
  end
  
  def press_brake(number)
    @current_speed -= number
    puts "You push the brake pedal and decelerated by #{@current_speed}"
  end
  
  def turn_engine_off
    @current_speed = 0
    puts "You turn the engine off"
  end
  
  def spray_paint(color)
    self.color = color
  end
              
  
  
end

bmw = MyCar.new('1997', 'BMW', "red")
puts bmw 
bmw.current_speed
bmw.speed_up(20)
bmw.current_speed
bmw.press_brake(10)
bmw.current_speed
bmw.turn_engine_off
bmw.color = 'black'
puts bmw.color
puts bmw.year 
bmw.spray_paint('red')
puts bmw.color