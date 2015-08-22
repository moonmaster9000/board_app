require "board/use_cases/read_entity_use_case"
require "board/use_cases/events/entities/event"

module Board
  module UseCases
    class ReadEventUseCase < ReadEntityUseCase
      def initialize(repo_factory:, event_id:, observer:)
        super(
          entity_repo: repo_factory.event_repo,
          entity_id: event_id,
          observer: observer,
          entity_name: :event,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def read_event(*args)
      ReadEventUseCase.new(*args)
    end
  end
end
