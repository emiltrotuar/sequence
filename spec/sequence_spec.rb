require 'sequence'

class Car
  include Sequence

  sequence :gear,   [:first, :second, :third]
  sequence :lights, [:daytime, :short_range, :long_range]
end

describe 'Sequence' do

  before(:all) do
    @car = Car.new
  end

  it 'responds to dynamically created methods' do
    [:gear,   :gear=,   :next_gear,
     :lights, :lights=, :next_lights
    ].
    each{ |method| expect(@car).to respond_to(method) }
  end

  it "returns the first item" do
    expect(@car.gear).to eq :first
    expect(@car.lights).to eq :daytime
  end

  it "returns the next item" do
    expect(@car.next_gear).to eq :second
    expect(@car.gear).to eq :second

    expect(@car.next_lights).to eq :short_range
    expect(@car.lights).to eq :short_range
  end

  it "performs the item assignment" do
    @car.gear = :third
    expect(@car.gear).to eq :third

    @car.lights = :long_range
    expect(@car.lights).to eq :long_range
  end
end