require "board/use_cases/private/use_cases/delete_entity_use_case"
require "board/use_cases/helps/entities/help"

module Board
  module UseCases
    class DeleteHelpUseCase < DeleteEntityUseCase
      def initialize(help_id:, repo_factory:, observer:)
        super(
          entity_id: help_id,
          observer: observer,
          repo: repo_factory.help_repo,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def delete_help(*args)
      UseCases::DeleteHelpUseCase.new(*args)
    end
  end
end
