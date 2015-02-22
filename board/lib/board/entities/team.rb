require "board/entities/entity"

module Board
  class ValidationError
    def initialize(field_name:, error:)
      @field_name = field_name
      @error = error
    end

    def ==(other_validation_error)
      true
    end
  end

  module Entities
    class Team < Entity
      set_attributes(
        :name,
        :id,
      )

      def valid?
        present?(@name)
      end

      def validation_errors
        [ValidationError.new(
          field_name: :name,
          error: :required,
        )]
      end

      private
      def present?(name)
        !name.empty?
      end
    end
  end
end
