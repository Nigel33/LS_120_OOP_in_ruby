class Parent
  def greeting
    "Hi from Parent"
  end

  def send
    "Hey"
  end
end

parent = Parent.new
puts parent.greeting
parent.send:greeting