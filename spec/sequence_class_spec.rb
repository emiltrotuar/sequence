require 'spec_helper'
require 'sequence/sequence_class'

describe SequenceClass do

  before(:all) do
    arr = [:jan, :feb, :mar, :apr]
    @seq = SequenceClass.new(arr) 
  end

  it 'responds to methods' do
    expect(@seq).to respond_to(:get_current_item)
    expect(@seq).to respond_to(:get_next_item)
    expect(@seq).to respond_to(:item_equals)
  end

  it 'returns first item' do
    expect(@seq.get_current_item).to eq :jan
  end

  it 'returns next item' do
    expect(@seq.get_next_item).to eq :feb
    expect(@seq.get_current_item).to eq :feb
  end

  it 'declines wrong item assignment' do
    expect(@seq.send(:item_equals, :apr)).to eq false
    expect(@seq.get_current_item).to eq :feb
  end

  it 'performs proper item assignment' do
    expect(@seq.item_equals(:mar)).to eq :mar
    expect(@seq.get_current_item).to eq :mar
  end
end