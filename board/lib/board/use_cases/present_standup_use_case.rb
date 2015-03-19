module Board
  module UseCases
    class PresentStandupUseCase
      def initialize(team_id:, new_face_repo:, observer:, help_repo:)
        @observer = observer
        @new_face_repo = new_face_repo
        @team_id = team_id
        @help_repo = help_repo
      end

      def execute
        standup = Values::Standup.new(
          new_faces: @new_face_repo.all_by_team_id(@team_id),
          helps: @help_repo.all_by_team_id(@team_id),
        )
        @observer.standup_presented(standup)
      end

      module Values
        class Standup
          attr_reader(
            :new_faces,
            :helps,
          )

          def initialize(new_faces:, helps:)
            @new_faces = new_faces
            @helps = helps
          end
        end
      end
    end
  end
end
