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
    class Team
      ATTRIBUTES = [:name, :id]

      attr_reader :name
      attr_accessor :id

      def initialize(id: nil, name: nil)
        @id = id
        @name = name
      end

      def ==(other_team)
        other_team.id == id
      end

      def valid?
        present?(@name)
      end

      def attributes
        {
          name: @name,
          id: @id,
        }
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
