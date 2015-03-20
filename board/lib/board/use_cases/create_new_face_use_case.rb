require "board/entities/new_face"
require "board/use_cases/create_entity_for_team_use_case"

module Board
  module UseCases
    class CreateNewFaceUseCase < CreateEntityForTeamUseCase
      def initialize(team_id:, new_face_repo:, attributes:, observer:)
        super(
          team_id: team_id,
          repo: new_face_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::NewFace,
        )
      end
    end
  end
end
