class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Dog
  def speak 
    "Meow!"
  end
  
  def swim 
    "Nope!"
  end
  
  def fetch 
    "Thats silly!"
  end
end

dogo = Dog.new
kitty = Cat.new
p kitty.fetch
p kitty.jump
p kitty.speak 