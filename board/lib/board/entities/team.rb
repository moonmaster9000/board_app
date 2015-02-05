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
      attr_reader :name
      attr_accessor :id

      def initialize(name: nil)
        @name = name
      end

      def valid?
        !@name.empty?
      end

      def validation_errors
        [ValidationError.new(
          field_name: :name,
          error: :required,
        )]
      end
    end
  end
end
