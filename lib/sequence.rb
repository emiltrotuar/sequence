require "sequence/version"
require "sequence/validator"

module Sequence

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # def sequence(item, array_of_items)
    #   instance_variable_set("@_#{item}_sequence", Sequence.new(array_of_items))
    # end

    # define_method(item) do
    #   instance_variable_get("@_#{item}_sequence”).get_current
    # end

    def sequence(item, array_of_items)

      define_method("initialize") do
        @current_item_index = 0
        @array_of_items = array_of_items
        @validator = Validator.new(array_of_items)
        @validator.validate_array
        self.singleton_class.send(:attr_reader, :validator,
                                                :array_of_items,
                                                :current_item_index)
      end

      define_method(item) do
        array_of_items[current_item_index]
      end

      define_method("#{item}=") do |itm|
        begin
          @current_item_index = validator.check_item(itm, current_item_index)
        rescue
          return false
        end
        itm
      end

      define_method("next_#{item}") do
        validator.validate_iteration(current_item_index) rescue return false
        @current_item_index += 1
        self.send(item)
      end
    end
  end
end