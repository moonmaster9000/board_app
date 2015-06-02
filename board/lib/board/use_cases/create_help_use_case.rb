require "board/use_cases/create_entity_for_whiteboard_use_case"
require "board/entities/help"

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
