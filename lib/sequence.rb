require "sequence/version"

module Sequence

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def sequence(item, array_of_items)

      define_method("initialize") do
        @current_index = 0
        @array_of_items = array_of_items
        validate_array(array_of_items)
        self.singleton_class.send(:attr_reader, :array_of_items, :current_index)
      end

      define_method(item) do
        array_of_items[current_index]
      end

      define_method("#{item}=") do |item|
        item_index = validate_item(item)
        return false unless item_index
        @current_index = item_index
        array_of_items[current_index]
      end

      define_method("next_#{item}") do
        res = validate_iteration
        return res if res
        @current_index += 1
        self.send(item)
      end

      define_method('validate_iteration') do
        if current_index >= array_of_items.size-1
          'iteration reached an end'
        end
      end

      define_method('validate_array') do |array|
        begin
          array = check_array_content(array)
        rescue ArgumentError => e
          puts e
          return false
        end
      end

      define_method('check_array_content') do |array|
        array.each do |array_item|
          unless array_item.is_a? Symbol
            raise ArgumentError, 'array should only consists of symbols'
          end
        end
        array
      end

      define_method('validate_item') do |item|
        begin
          item       = check_type(item)
          item_index = check_index(item)
        rescue ArgumentError => e
          puts e
        rescue Exception
          return
        end
      end

      define_method('check_type') do |item|
        unless item.is_a? Symbol
          raise ArgumentError, 'assigned value should be a symbol'
        end
        item
      end

      define_method('check_index') do |item|
        item_index = array_of_items.index(item)
        if !item_index
          raise Exception, 'sequence not contain such item'
        elsif item_index >= current_index+2
          raise Exception
        end
        item_index
      end
    end
  end
end