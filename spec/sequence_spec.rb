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
    expect(car).to respond_to(:current_item_index)
    expect(car).to respond_to(:array_of_items)
  end

  context 'get values from sequence' do
    before(:all) do
      @car = Car.new
    end

    it "returns a first value of sequence" do
      expect(@car.gear).to eq :first
    end

    it "return next value in sequence" do
      expect(@car.next_gear).to eq :second
    end

    it "assigns value if it's next to current and returns it" do
      @car.gear = :third
      expect(@car.gear).to eq :third
    end
  end

  context 'exception handling' do
    it 'returns false if one tries to assign value that higher than current but not next to it' do
      car.gear = :first
      expect( car.send(:gear=, :third) ).to eq false
    end

    it 'stops iteration when sequence reached an end' do
      car.next_gear
      car.next_gear
      car.next_gear
      expect(car.next_gear).to eq false
    end
  end

  context 'validation errors' do
    it 'validates an array' do
      array = [:first, :second, 'third', 4]
      expect do 
        car.validate_array(array)
      end.to raise_error('array should only consists of symbols')
    end

    it 'assings a values of proper type' do
      expect do 
        car.check_type('first')
      end.to raise_error('assigned value should be a symbol')
    end

    it 'checks if item belongs to array' do
      expect do 
        car.check_index(:fifth)
      end.to raise_error('wrong assignment')
    end
  end
end