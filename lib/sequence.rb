require "sequence/version"

module Sequence
  instance_eval %{
    def sequence(item, array_of_items)
      attr_accessor :current_item, :array_of_items
      
      item = item.to_
      @array_of_items = array_of_items
      @current_item   = 0

      define_method(item.to_s) do
        array_of_items[current_item]
      end

      define_method('next'+item.to.s) do
        current_item += 1
        array_of_items[current_item]
      end
    end
  }

  class Example
    # include Sequence

    # sequence :item, [:first, :second, :third, :fourth]

    attr_accessor :current_index, :array_of_items

    def initialize
      @array_of_items = [:first, :second, :third, :fourth]
      validate_array(array_of_items)
      @current_index = 0
    end

    def item
      binding.pry
      array_of_items[current_index]
    end

    def item=(item)
      item = validate_item(item)
      return unless item
      item_index = check_index(item)
      return unless item_index
      current_index = item_index
      array_of_items[current_index]
    end

    def next_item
      binding.pry
      current_index = current_index + 1
      item
    end

    private

    def validate_array(array)
      begin
        array = check_array(array)
      rescue ArgumentError => e
        puts e
        return false
      end
    end

    def check_array(array)
      array.each do |array_item|
        unless array_item.is_a? Symbol
          raise ArgumentError, 'array should only consists of symbols'
        end
      end
      array
    end

    def validate_item(item)
      begin
        raise ArgumentError, 'assigned value should be a symbol' unless item.is_a? Symbol
      rescue ArgumentError => e
        puts e
        return nil
      end
      item
    end

    def check_index(item)
      item_index = array_of_items.index(item)
      return false if !item_index || (item_index >= current_index+2)
      item_index
    end
  end
end
