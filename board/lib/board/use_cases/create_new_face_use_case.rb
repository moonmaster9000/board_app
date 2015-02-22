module Board
  module UseCases
    class CreateNewFaceUseCase
      def initialize(team_id:, new_face_repo:, attributes:, observer:)
        @team_id = team_id
        @new_face_repo = new_face_repo
        @attributes = attributes
        @observer = observer
      end

      def execute
        new_face = Entities::NewFace.new(@attributes)

        if new_face.valid?
          @new_face_repo.save(new_face)
          @observer.new_face_created(new_face)
        else
          @observer.validation_failed(new_face.validation_errors)
        end
      end
    end
  end
end
