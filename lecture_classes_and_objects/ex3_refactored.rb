class Person
  attr_accessor :first_name, :last_name 
  
  def initialize(full_name)
    parse_full_name(full_name)
  end
  
  def name 
    self.first_name + ' ' + self.last_name         
  end 
  
  def name= (full_name)
    parse_full_name(full_name) 
  end
  
  private 
  
  def parse_full_name(full_name)
    array = full_name.split
    @first_name = array[0]
    @last_name = array.size > 1? array[1] : ''         
  end 
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'