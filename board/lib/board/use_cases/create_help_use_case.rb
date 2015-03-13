require "board/entities/validations"

module Board
  module UseCases
    class CreateHelpUseCase
      def initialize(attributes:, help_repo:, observer:)
        @observer = observer
        @help_repo = help_repo
        @attributes = attributes
      end

      def execute
        @observer.validation_failed([Board::Entities::Validations::ValidationError.new(field_name: :date, error: :required)])
      end
    end
  end
end
