require "sequence/version"
require "sequence/sequence_class"

module Sequence

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def sequence(item, array_of_items)
      instance_variable_set("@_#{item}_sequence", SequenceClass.new(array_of_items))

      define_method(item) do
        self.class.instance_variable_get("@_#{item}_sequence").get_current_item
      end

      define_method("#{item}=") do |itm|
        self.class.instance_variable_get("@_#{item}_sequence").item_equals(itm)
      end

      define_method("next_#{item}") do
        self.class.instance_variable_get("@_#{item}_sequence").get_next_item
      end
    end
  end
end