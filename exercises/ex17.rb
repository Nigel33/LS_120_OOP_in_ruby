class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end

end

class Owner
  attr_accessor :name, :pets
  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pets(animal)
    pets << animal
  end

  def show
    puts "#{name} has adopted the following pets: "
    pets.each {|animal| puts animal }
  end

  def number_of_pets
    pets.size
  end

  def to_s
    @name
  end

end

class Shelter
  attr_accessor :owner

  def initialize
    @owner = []
  end

  def adopt(person,animal)
    person.add_pets(animal)
    owner << person unless owner.include?(person)
  end

  def print_adoptions
    owner.each do |person|
      person.show
    end
  end
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."