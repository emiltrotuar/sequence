require 'sequence/validator'

class SequenceClass
  attr_reader :validator, :array_of_items, :current_item_index

  def initialize(array_of_items)
    @current_item_index = 0
    @array_of_items     = array_of_items
    @validator          = Validator.new(array_of_items)
    @validator.validate_array
  end

  def get_current_item
    array_of_items[current_item_index]
  end

  def get_next_item
    validator.validate_iteration(current_item_index)
    @current_item_index += 1
    get_current_item
  end

  def item_equals(itm)
    @current_item_index = validator.validate_item(itm, current_item_index)
    itm
  end
end