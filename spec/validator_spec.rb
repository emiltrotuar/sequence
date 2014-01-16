require 'spec_helper'
require 'sequence/validator'

describe Validator do

  it 'validates an array' do
    array = [:first, :second, 'third', 4]
    validator = described_class.new(array)
    expect do 
      validator.validate_array
    end.to raise_error('array should only consists of symbols')
  end

  it 'validates iteration' do
    array_of_items = [:first, :second, :third, :fourth]
    current_index = 3
    validator = described_class.new(array_of_items)
    expect do 
      validator.validate_iteration(current_index)
    end.to raise_error('iteration reached an end')
  end

  context 'check item' do
    before do
      array_of_items = [:first, :second, :third, :fourth]
      @validator = described_class.new(array_of_items)
    end

    it 'assings a values of proper type' do
      expect do 
        @validator.check_type('first')
      end.to raise_error('assigned value should be a symbol')
    end

    it 'checks if item belongs to array' do
      FIRST_ITEM_INDEX = 0
      expect do 
        @validator.check_index(:third, FIRST_ITEM_INDEX)
      end.to raise_error('wrong assignment')
    end
  end
end