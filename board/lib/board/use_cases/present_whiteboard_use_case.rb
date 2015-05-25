require "board/values/whiteboard"

module Board
  module UseCases
    class PresentWhiteboardUseCase
      def initialize(team_id:, observer:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @team_id = team_id
      end

      def execute
        @observer.whiteboard_presented(
          Board::Values::Whiteboard.new(
            new_faces: @repo_factory.new_face_repo.unarchived_by_team_id(@team_id),
          )
        )
      end
    end
  end
end
