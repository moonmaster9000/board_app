require "board/entities/new_face"

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
        if valid?
          persist
          send_new_face_to_observer
        else
          send_errors_to_observer
        end
      end

      private
      attr_reader(
        :new_face_repo,
        :team_id,
        :attributes,
        :observer,
      )

      def send_errors_to_observer
        observer.validation_failed(new_face.validation_errors)
      end

      def send_new_face_to_observer
        observer.new_face_created(new_face)
      end

      def persist
        new_face_repo.save(new_face)
      end

      def valid?
        new_face.valid?
      end

      def new_face
        @new_face ||= Entities::NewFace.new(@attributes)
      end
    end
  end
end
