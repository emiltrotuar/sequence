require "sequence/validator"

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

  def item_equals(itm)
    begin
      @current_item_index = validator.check_item(itm, current_item_index)
      itm
    rescue
      return false
    end
  end

  def get_next_item
    validator.validate_iteration(current_item_index) rescue return false
    @current_item_index += 1
    get_current_item
  end
end