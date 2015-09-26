require "board/use_cases/private/use_cases/delete_entity_use_case"
require "board/use_cases/interestings/entities/interesting"

module Board
  module UseCases
    class DeleteInterestingUseCase < DeleteEntityUseCase
      def initialize(interesting_id:, repo_factory:, observer:)
        super(
          entity_id: interesting_id,
          observer: observer,
          repo: repo_factory.interesting_repo,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def delete_interesting(*args)
      UseCases::DeleteInterestingUseCase.new(*args)
    end
  end
end
