module Board
  module Entities
    module Validations
      def self.included(klass)
        klass.extend ClassMethods
        klass.send(:include, InstanceMethods)
      end

      module ClassMethods
        def validate_field(field_name, validation, *validation_args)
          validation_class = const_get(validation.to_s.capitalize)
          field_validations << validation_class.new(field_name, *validation_args)
        end

        def field_validations
          @validations ||= []
        end
      end

      module InstanceMethods
        def valid?
          invalid_field_validations.empty?
        end

        def validation_errors
          invalid_field_validations.map do |invalid|
            ValidationError.new(
              field_name: invalid.field_name,
              error: invalid.error_code
            )
          end
        end


        private

        def invalid_field_validations
          all_validations - valid_field_validations
        end

        def valid_field_validations
          self.class.field_validations.select {|v| v.valid?(self) }
        end

        def all_validations
          self.class.field_validations
        end
      end

      class ValidationError
        attr_reader(
          :field_name,
          :error,
        )

        def initialize(field_name:, error:)
          @field_name = field_name
          @error = error
        end
      end

      class Inclusion
        attr_reader :field_name

        def initialize(field_name, values:)
          @field_name = field_name
          @values = values
        end

        def valid?(entity)
          @values.any? { |v| entity.send(@field_name) == v }
        end

        def error_code
          :inclusion
        end
      end

      class Required
        attr_reader :field_name

        def initialize(field_name)
          @field_name = field_name
        end

        def valid?(entity)
          !invalid?(entity)
        end

        def invalid?(entity)
          field_value = entity.send(field_name)

          field_value.nil? || (
            field_value.respond_to?(:empty?) &&
            field_value.empty?
          )
        end

        def error_code
          :required
        end
      end
    end
  end
end
