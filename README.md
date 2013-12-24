class Car
  include Sequence
 
  sequence :gear, [:first, :second, :third, :fourth]
end
 
car = Car.new
car.gear # => :first
car.next_gear # => :second
car.gear # => :second
 
car.gear = :fourth # => false
car.gear # => :second
 
car.gear = :third # => :third
car.gear # => :third