require 'spec_helper'
require 'sequence'

class Car
  include Sequence

  sequence :gear,   [:first, :second, :third, :fourth]
  sequence :lights, [:daytime, :short_range, :long_range]
end

describe 'Sequence' do

  let(:car) { Car.new }

  it 'responds to dynamically created methods' do
    [:gear,   :gear=,   :next_gear,
     :lights, :lights=, :next_lights
    ].
    each{ |method| expect(car).to respond_to(method) }
  end

  context 'operations with sequence' do
    before(:all) do
      @car = Car.new
    end

    it "returns the first value" do
      expect(@car.gear).to eq :first
      expect(@car.lights).to eq :daytime
    end

    it "returns the next value" do
      expect(@car.next_gear).to eq :second
      expect(@car.gear).to eq :second

      expect(@car.next_lights).to eq :short_range
      expect(@car.lights).to eq :short_range
    end

    it "assigns value if it's next to current" do
      @car.gear = :third
      expect(@car.gear).to eq :third

      @car.lights = :long_range
      expect(@car.lights).to eq :long_range
    end
  end

  context 'exceptions handling' do
    it 'returns false if one tries to assign value that higher than current but not next to it' do
      car.gear = :first
      expect( car.send(:gear=, :third) ).to eq false
    end

    it 'stops iteration when sequence reached an end' do
      3.times { car.next_gear }
      expect(car.next_gear).to eq false
    end
  end
end