class Validator

  attr_reader :array

  def initialize(array_of_items)
    @array = array_of_items
  end

  def validate_array
    array.each do |array_item|
      unless array_item.is_a? Symbol
        raise 'array should only consists of symbols'
      end
    end
  end

  def validate_iteration(current_item_index)
    if current_item_index >= array.size-1
      raise 'iteration reached an end'
    end
  end

  def validate_item(item,current_item_index)
    check_type(item)
    check_presence(item)
    check_index(current_item_index, item_index(item))
  end

  def item_index(item)
    array.index(item)
  end

  def check_type(item) 
    unless item.is_a? Symbol
      raise ArgumentError, 'assigned value should be a symbol'
    end
  end

  def check_presence(item)
    unless array.include? item
      raise ArgumentError, 'array not contain this element'
    end
  end

  def check_index(current_item_index, item_index)
    if item_index > current_item_index+1
      raise ArgumentError,
      <<-E
      \n
         assigned value should not be higher than the next to current value:
         ===================================================================
         current item index:   #{current_item_index}
         assigning item index: #{item_index}
      E
    end
    current_item_index = item_index
  end
end