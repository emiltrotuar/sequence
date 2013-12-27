module Sequence
  class Validator
    def initialize()
      array
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

    def check_item(item)
      check_type(item)
      check_index(item)
    end

    define_method('check_type') do |item|
      unless item.is_a? Symbol
        raise 'assigned value should be a symbol'
      end
    end

    define_method('check_index') do |item|
      item_index = array.index(item)
      if !item_index || item_index >= current_item_index+2
        raise 'wrong assignment'
      end
      @current_item_index = item_index
    end
  end
end