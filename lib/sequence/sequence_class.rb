class Sequence

  def initialize
    @current_item_index = 0
    @array_of_items = array_of_items
    @validator = Validator.new(array_of_items)
    @validator.validate_array
    self.singleton_class.send(:attr_reader, :validator,
      :array_of_items,
      :current_item_index)
  end

  def item
    array_of_items[current_item_index]
  end

  def item=(itm)
    begin
      @current_item_index = validator.check_item(itm, current_item_index)
    rescue
      return false
    end
    itm
  end

  def next_item
    validator.validate_iteration(current_item_index) rescue return false
    @current_item_index += 1
    self.send(item)
  end
end