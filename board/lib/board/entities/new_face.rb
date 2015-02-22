require "board/entities/entity"

module Board
  module Entities
    class NewFace < Entity
      set_attributes(
        :id,
        :name,
        :date,
      )

      def valid?
        validation_errors.empty?
      end

      def validation_errors
        Validate.new(entity: self).errors
      end

      class Validate
        def initialize(entity:)
          @entity = entity
          @errors = []
        end

        def errors
          reset_errors
          validate_name
          validate_date
          @errors
        end


        private
        attr_reader :entity

        def validate_date
          if entity.date.nil?
            @errors << ValidationError.new(
              field_name: :date,
              error: :required,
            )
          end
        end

        def reset_errors
          @errors = []
        end

        def validate_name
          if entity.name.empty?
            @errors << ValidationError.new(
              field_name: :name,
              error: :required,
            )
          end
        end
      end
    end
  end
end
