module Sequence
  class Validator
    attr_reader :array, :current_item_index

    def initialize(array_of_items)
      @array = array_of_items
    end

    def validate_iteration(current_item_index)
      if current_item_index >= array.size-1
        raise 'iteration reached an end'
      end
    end

    def validate_array
      array.each do |array_item|
        unless array_item.is_a? Symbol
          raise ArgumentError, 'array should only consists of symbols'
        end
      end
    end

    def check_item(item,current_item_index)
      check_type(item)
      check_index(item,current_item_index)
    end

    def check_type(item) 
      unless item.is_a? Symbol
        raise 'assigned value should be a symbol'
      end
    end

    def check_index(item,current_item_index)
      item_index = array.index(item)
      if !item_index || item_index >= current_item_index+2
        raise 'wrong assignment'
      end
      current_item_index = item_index
    end
  end
end