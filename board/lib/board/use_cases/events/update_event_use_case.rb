require "board/use_cases/update_entity_for_whiteboard_use_case"
require "board/use_cases/events/entities/event"

module Board
  module UseCases
    class UpdateEventUseCase < UpdateEntityForWhiteboardUseCase
      def initialize(event_id:, repo_factory:, attributes:, observer:)
        super(
          entity_id: event_id,
          repo: repo_factory.event_repo,
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
    def update_event(*args)
      UseCases::UpdateEventUseCase.new(*args)
    end
  end
end
