require 'sequence/sequence_class'

describe SequenceClass do

  before(:all) do
    items = [:first, :second, :third]
    @seq = described_class.new(items) 
  end

  it 'responds to the methods' do
    expect(@seq).to respond_to(:get_current_item)
    expect(@seq).to respond_to(:get_next_item)
    expect(@seq).to respond_to(:item_equals)
  end

  it 'returns the first item' do
    expect(@seq.get_current_item).to eq :first
  end

  it 'returns the next item' do
    expect(@seq.get_next_item).to eq :second
    expect(@seq.get_current_item).to eq :second
  end

  it 'performs the item assignment' do
    expect(@seq.item_equals(:third)).to eq :third
    expect(@seq.get_current_item).to eq :third
  end
end