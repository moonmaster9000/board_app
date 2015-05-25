module Board
  module Entities
    module Entity
      module AttributeManagementClassMethods
        def add_attributes(*attrs)
          attributes.unshift *attrs
          attr_accessor *attrs
        end

        def attributes
          @attributes ||= []
        end
      end

      module AttributeManagementInstanceMethods
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

        private
        def attribute_names
          self.class.attributes
        end
      end

      module EntityEquality
        def ==(other_entity)
          other_entity.id == id
        end
      end

      def self.included(klass)
        klass.extend AttributeManagementClassMethods
        klass.send :include, AttributeManagementInstanceMethods
        klass.send :include, EntityEquality
        klass.add_attributes(:id)
      end
    end
  end
end
