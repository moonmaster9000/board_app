require "board/use_cases/create_entity_for_team_use_case"
require "board/entities/event"

module Board
  module UseCases
    class CreateEventUseCase < CreateEntityForTeamUseCase
      def initialize(team_id:, event_repo:, attributes:, observer:)
        super(
          team_id: team_id,
          repo: event_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::Event,
        )
      end
    end
  end
end
