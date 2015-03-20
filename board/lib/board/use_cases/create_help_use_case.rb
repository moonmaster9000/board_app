require "board/use_cases/create_entity_for_team_use_case"
require "board/entities/help"

module Board
  module UseCases
    class CreateHelpUseCase < CreateEntityForTeamUseCase
      def initialize(team_id:, help_repo:, attributes:, observer:)
        super(
          team_id: team_id,
          repo: help_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Help
        )
      end
    end
  end
end
