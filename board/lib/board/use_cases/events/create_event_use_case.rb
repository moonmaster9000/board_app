require "board/use_cases/create_entity_for_whiteboard_use_case"
require "board/use_cases/events/entities/event"

module Board
  module UseCases
    class CreateEventUseCase < CreateEntityForWhiteboardUseCase
      def initialize(whiteboard_id:, event_repo:, attributes:, observer:)
        super(
          whiteboard_id: whiteboard_id,
          repo: event_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Event,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def create_event(*args)
      UseCases::CreateEventUseCase.new(*args)
    end
  end
end
