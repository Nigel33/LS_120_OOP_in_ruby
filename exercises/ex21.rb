class Machine
  attr_writer :switch

  def start #remove self. because cannot call directly from object 
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private

  def flip_switch(desired_state)
    self.switch = desired_state #must call self.switch otherwise create new local variable 
  end

  def switch=(value)
    switch = value
  end

end

machine = Machine.new
machine.start
machine.stop