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
    expect(car).to respond_to(:gear)
    expect(car).to respond_to(:next_gear)
  end

  it 'iterates through sequence' do
    expect(car.gear).to eq :first
    expect(car.next_gear).to eq :second
    expect(car.gear).to eq :second
    expect(car.send(:gear=, :fourth)).to eq false
    expect(car.gear).to eq :second

    car.gear = :third
    expect(car.gear).to eq :third

    expect(car.next_gear).to eq :fourth
    expect(car.next_gear).to eq 'iteration reached an end'
  end
end