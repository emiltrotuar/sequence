require 'sequence/validator'

describe Validator do

  let(:items)     { [:first, :second, :third] }

  let(:validator) { described_class.new(items) }

  it 'checks whether an array contains only symbols' do
    items[0] = 'first'
    expect do 
      validator.validate_array
    end.to raise_error('array should only consists of symbols')
  end

  it 'checks whether an iteration reached an end'  do
    last_index_in_array = 2
    expect do 
      validator.validate_iteration(last_index_in_array)
    end.to raise_error('iteration reached an end')
  end

  context 'when performs item validation' do

    it 'defines the item index' do
      expect(validator.item_index(items[0])).to eq 0
    end

    it 'allows only the symbols' do
      expect do 
        validator.check_type('not_a_symbol')
      end.to raise_error(ArgumentError,'assigned value should be a symbol')
    end

    it 'checks the presence in array' do
      expect do 
        validator.check_presence(:non_existent_element)
      end.to raise_error(ArgumentError,'array not contain this element')
    end

    it 'declines the wrong item assignment' do
      current_index = 0
      item_index = current_index+2
      expect do 
        validator.check_index(current_index, item_index)
      end.to raise_error ArgumentError,
      <<-E
      \n
         assigned value should not be higher than the next to current value:
         ===================================================================
         current item index:   0
         assigning item index: 2
      E
    end
  end
end