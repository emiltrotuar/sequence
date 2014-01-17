require 'sequence/version'
require 'sequence/sequence_class'

module Sequence

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def sequence(item, array_of_items)
      instance_variable_set("@_#{item}_sequence", SequenceClass.new(array_of_items))

      [item, "#{item}=", "next_#{item}"].each do |method|
        if self.instance_methods.include? :"#{method}"
          raise "method #{method} already exists"
        end
      end

      define_method(item) do
        self.class.sq(item).get_current_item
      end

      define_method("next_#{item}") do
        self.class.sq(item).get_next_item
      end

      define_method("#{item}=") do |itm|
        self.class.sq(item).item_equals(itm)
      end
    end

    def sq(item)
      instance_variable_get("@_#{item}_sequence")
    end
  end
end