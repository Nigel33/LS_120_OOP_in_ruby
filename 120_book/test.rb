class Person
  attr_accessor :first_name, :last_name 
  
  def initialize(full_name)
    @first_name = full_name.split[0]
    if full_name.split[1] == nil
      @last_name = ''
    else
      @last_name = full_name.split[1]
    end 
  end
  
  def name
    @first_name + ' ' + @last_name 
  end
  
  def name= (full_name)
    parts = full_name.split 
    self.first_name = parts.first 
    self.last_name = parts.last  
  end
  
  
  
   
end

bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name  

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name 