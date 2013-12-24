require 'spec_helper'
require 'sequence'

class Foo
  include Sequence

  sequence :item, [:first, :second, :third, :fourth]
end

describe 'Sequence' do

  before do	
    foo = Foo.new
  end

  it 'responds to new methods' do
    foo.should respond_to(item)
    foo.should respond_to(next_item)
  end

  it 'adds iterates through' do
    foo.item.should eq :first
    foo.next_item.should eq :second
    foo.should_receive(:item=).with(:forth).and_return('false')
    foo.item = :fourth
    foo.item.should eq :second

    foo.should_receive(:item=).with(:third).and_return(:third)
    foo.item = :third
    foo.item.should eq :third

    foo.next_item.should eq :forth
    expect {foo.next_item}.to raise_error('iteration reached an end')
  end
end