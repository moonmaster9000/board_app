module Board
  module UseCases
    class PresentStandupUseCase
      module Values
        class Standup
          attr_reader :new_faces

          def initialize(new_faces:)
            @new_faces = new_faces
          end
        end
      end

      def initialize(team_id:, new_face_repo:, observer:)
        @observer = observer
        @new_face_repo = new_face_repo
        @team_id = team_id
      end

      def execute
        standup = Values::Standup.new(new_faces: @new_face_repo.all)
        @observer.standup_presented(standup)
      end
    end
  end
end
