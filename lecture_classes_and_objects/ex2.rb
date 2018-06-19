class Person
  attr_accessor :first_name, :last_name 
  
  def initialize(full_name)
   array = full_name.split 
   @first_name = array[0]
   @last_name = array.size > 1?  array[1] : '' 
  end
  
  def name 
    self.first_name + ' ' + self.last_name         
  end 
  
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'