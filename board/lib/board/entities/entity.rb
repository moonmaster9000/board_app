module Board
  module Entities
    class Entity
      class << self
        def set_attributes(*attrs)
          @attributes = attrs
          attr_accessor *attrs
        end

        attr_reader :attributes
      end

      def initialize(attributes={})
        attribute_names.each do |attribute_name|
          instance_variable_set(:"@#{attribute_name}", attributes[attribute_name])
        end
      end

      def ==(other_entity)
        other_entity.id == id
      end

      def attributes
        attrs = {}

        attribute_names.each do |attribute|
          attrs[attribute] = send attribute
        end

        attrs
      end

      private
      def attribute_names
        self.class.attributes
      end
    end
  end
end
