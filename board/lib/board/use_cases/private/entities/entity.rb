module Board
  module Entities
    class Entity
      class << self
        def add_attributes(*attrs)
          attrs.each do |attr|
            add_attribute(attr)
          end

          attr_accessor *attrs
        end

        def attributes
          all_attrs = []
          all_attrs += self_attributes
          all_attrs += ancestor_attributes
          all_attrs.uniq
        end

        def add_attribute(attr)
          self_attributes << attr
        end

        def self_attributes
          @self_attributes ||= []
        end

        def ancestor_attributes
          ancestors.map do |ancestor|
            next if ancestor == self
            next if !ancestor.respond_to?(:attributes)

            ancestor.attributes
          end.compact.flatten
        end
      end

      add_attributes(:id)

      def initialize(attributes={})
        attribute_names.each do |attribute_name|
          instance_variable_set(:"@#{attribute_name}", attributes[attribute_name])
        end
      end

      def attributes
        attrs = {}

        attribute_names.each do |attribute|
          attrs[attribute] = send attribute
        end

        attrs
      end

      def ==(other_entity)
        other_entity.id == id
      end

      private
      def attribute_names
        self.class.attributes
      end
    end
  end
end
