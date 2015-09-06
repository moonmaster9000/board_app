require "board/use_cases/read_entity_use_case"
require "board/use_cases/interestings/entities/interesting"

module Board
  module UseCases
    class ReadInterestingUseCase < ReadEntityUseCase
      def initialize(repo_factory:, interesting_id:, observer:)
        super(
          entity_repo: repo_factory.interesting_repo,
          entity_id: interesting_id,
          observer: observer,
          entity_name: :interesting,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def read_interesting(*args)
      UseCases::ReadInterestingUseCase.new(*args)
    end
  end
end
