require "board/use_cases/private/shared/use_cases/update_entity_for_whiteboard_use_case"
require "board/use_cases/interestings/entities/interesting"

module Board
  module UseCases
    class UpdateInterestingUseCase < UpdateEntityForWhiteboardUseCase
      def initialize(interesting_id:, repo_factory:, attributes:, observer:)
        super(
          entity_id: interesting_id,
          repo: repo_factory.interesting_repo,
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
    def update_interesting(*args)
      UseCases::UpdateInterestingUseCase.new(*args)
    end
  end
end
