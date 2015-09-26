require "board/use_cases/private/use_cases/delete_entity_use_case"
require "board/use_cases/events/entities/event"

module Board
  module UseCases
    class DeleteEventUseCase < DeleteEntityUseCase
      def initialize(event_id:, repo_factory:, observer:)
        super(
          entity_id: event_id,
          observer: observer,
          repo: repo_factory.event_repo,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def delete_event(*args)
      UseCases::DeleteEventUseCase.new(*args)
    end
  end
end
