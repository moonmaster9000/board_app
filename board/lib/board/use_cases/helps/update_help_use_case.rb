require "board/use_cases/update_entity_for_whiteboard_use_case"
require "board/use_cases/helps/entities/help"

module Board
  module UseCases
    class UpdateHelpUseCase < UpdateEntityForWhiteboardUseCase
      def initialize(help_id:, repo_factory:, attributes:, observer:)
        super(
          entity_id: help_id,
          repo: repo_factory.help_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Help,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def update_help(*args)
      UseCases::UpdateHelpUseCase.new(*args)
    end
  end
end
