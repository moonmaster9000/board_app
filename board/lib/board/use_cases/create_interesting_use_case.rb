require "board/use_cases/create_entity_for_team_use_case"
require "board/entities/interesting"

module Board
  module UseCases
    class CreateInterestingUseCase < CreateEntityForTeamUseCase
      def initialize(team_id:, interesting_repo:, attributes:, observer:)
        super(
          team_id: team_id,
          repo: interesting_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Interesting,
        )
      end
    end
  end
end
