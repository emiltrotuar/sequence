require 'spec_helper'
require 'sequence'
require 'pry'

class Car
  include Sequence

  sequence :gear, [:first, :second, :third, :fourth]
end

describe 'Sequence' do

  let(:car) { Car.new }

  it 'responds to dynamically created methods' do
    car.should respond_to(:gear)
    car.should respond_to(:next_gear)
  end

  it 'iterates through sequence' do
    car.gear.should eq :first
    car.next_gear.should eq :second
    car.gear.should eq :second
    car.gear = :fourth
    car.gear.should eq :second

    car.gear = :third
    car.gear.should eq :third

    car.next_gear.should eq :fourth
    car.next_gear.should eq 'iteration reached an end'
  end
end