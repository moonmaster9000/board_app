require "board/use_cases/read_entity_use_case"
require "board/use_cases/helps/entities/help"

module Board
  module UseCases
    class ReadHelpUseCase < ReadEntityUseCase
      def initialize(repo_factory:, help_id:, observer:)
        super(
          entity_repo: repo_factory.help_repo,
          entity_id: help_id,
          observer: observer,
          entity_name: :help,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def read_help(*args)
      UseCases::ReadHelpUseCase.new(*args)
    end
  end
end
