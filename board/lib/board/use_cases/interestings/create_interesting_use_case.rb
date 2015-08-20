require "board/use_cases/create_entity_for_whiteboard_use_case"
require "board/use_cases/interestings/entities/interesting"

module Board
  module UseCases
    class CreateInterestingUseCase < CreateEntityForWhiteboardUseCase
      def initialize(whiteboard_id:, interesting_repo:, attributes:, observer:)
        super(
          whiteboard_id: whiteboard_id,
          repo: interesting_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Interesting,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def create_interesting(*args)
      CreateInterestingUseCase.new(*args)
    end
  end
end
