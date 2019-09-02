# Sample output

# Creating a new Honda!
# Honda
# Creating a new Ford!
# Creating a new Honda!
# Counting cars of same make as h2...
# There are 2.
# Counting total cars...
# There are 3.
# Traceback (most recent call last):
# 	2: from main.rb:68:in `<main>'
# 	1: from main.rb:68:in `new'
# main.rb:45:in `initialize': No such make: Brand X. (RuntimeError)

# Before refactoring. Using class variables
class Car
  @@makes = []
  @@cars = {}
  @@total_count = 0
  attr_reader :make
  def self.total_count
    @@total_count
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}!"
      @make = make
      @@cars[make] += 1
      @@total_count += 1
    else
      raise "No such make: #{make}."
    end
  end

  def make_mates
    @@cars[make]
  end
end

# After refactoring using instance variables
class Car

  # @@total_count = 0
  # attr_reader :make
  
  def self.cars_hash 
    @cars ||= {} 
  end

  def self.makes
    @makes ||= []
  end

  def self.total_count
    @total_count ||= 0
  end

  def self.total_count= (n)
    @total_count = n
  end

  def make
    @make
  end
  def self.add_make(make)
    unless self.makes.include?(make)
      self.makes << make
      self.cars_hash[make] = 0
    end
  end

  def initialize(make)
    if self.class.makes.include?(make)
      puts "Creating a new #{make}!"
      @make = make
      # no setter method is required to execute the line below
      self.class.cars_hash[make] += 1
      self.class.total_count += 1
      # self.class.total_count = self.class.total_count + 1
      # the assignment above is read as a method call to self.class.total_count= 
      # this type of confusing method calls does not hold true for arrays and hashes

    else
      raise "No such make: #{make}."
    end
  end

  def make_mates
    self.class.cars_hash[make]
  end
end


Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
puts h.make
f = Car.new("Ford")
h2 = Car.new("Honda")

puts "Counting cars of same make as h2..."
puts "There are #{h2.make_mates}."

puts "Counting total cars..."
puts "There are #{Car.total_count}."

x = Car.new("Brand X")