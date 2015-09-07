require "board/use_cases/private/use_cases/create_entity_for_whiteboard_use_case"
require "board/use_cases/helps/entities/help"

module Board
  module UseCases
    class CreateHelpUseCase < CreateEntityForWhiteboardUseCase
      def initialize(whiteboard_id:, help_repo:, attributes:, observer:)
        super(
          whiteboard_id: whiteboard_id,
          repo: help_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Help
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def create_help(*args)
      UseCases::CreateHelpUseCase.new(*args)
    end
  end
end
