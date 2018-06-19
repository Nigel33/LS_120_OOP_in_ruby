module Towable
  
  def can_tow?(pounds)
    return true if pounds < 2000
    return false 
  end

end


class Vehicle
   
   attr_accessor :color, :year, :model
   
   @@number_of_vehicles = 0
   
   def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def self.number_of_vehicles
    @@number_of_vehicles
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
  
  def age
    "Your #{self.model} is #{years_old} years old "
  end
  
  private
  
  def years_old
    Time.now.year - self.year
  end
  
  
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "This car is #{year} years old, #{color} and #{model} model"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DORRS = 2
  
  include Towable
  
  def to_s
    "This truck is made in #{year} , #{color} and #{model} model"
  end
end

car = MyCar.new(1957, 'white', 'lumina')
MyCar.calculate_gas_mileage(52,2)
puts car 
truck = MyTruck.new(2010, 'black', 'Ford')
puts truck 

puts car.age
# puts Vehicle.number_of_vehicles

# puts truck.can_tow?(1500)
# puts truck.can_tow?(4500)

# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors