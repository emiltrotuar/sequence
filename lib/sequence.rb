require "sequence/version"

module Sequence

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def sequence(item, array_of_items)

      define_method("initialize") do
        @current_item_index = 0
        @array_of_items = array_of_items
        validate_array(array_of_items) rescue return
        self.singleton_class.send(:attr_reader, :array_of_items, :current_item_index)
      end

      define_method(item) do
        array_of_items[current_item_index]
      end

      define_method("#{item}=") do |itm|
        get_index(itm) rescue return false
        self.send(item)
      end

      define_method("next_#{item}") do
        validate_iteration rescue return false
        @current_item_index += 1
        self.send(item)
      end

      define_method('validate_iteration') do
        if current_item_index >= array_of_items.size-1
          raise 'iteration reached an end'
        end
      end

      define_method('validate_array') do |array|
        array.each do |array_item|
          unless array_item.is_a? Symbol
            raise ArgumentError, 'array should only consists of symbols'
          end
        end
      end

      define_method('get_index') do |item|
        check_type(item)
        check_index(item)
      end

      define_method('check_type') do |item|
        unless item.is_a? Symbol
          raise 'assigned value should be a symbol'
        end
      end

      define_method('check_index') do |item|
        item_index = array_of_items.index(item)
        if !item_index || item_index >= current_item_index+2
          raise 'wrong assignment'
        end
        @current_item_index = item_index
      end
    end
  end
end