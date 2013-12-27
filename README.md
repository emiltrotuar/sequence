## Installation

```ruby
gem specific_install -l https://github.com/emiltrotuar/sequence.git
```
or add the following line in Gemfile:
```ruby
gem 'sequence', git: 'https://github.com/emiltrotuar/sequence.git'
```
and run `bundle`

## Usage

```ruby
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
```