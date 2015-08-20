require "board/use_cases/new_faces/entities/new_face"
require "board/use_cases/create_entity_for_whiteboard_use_case"

module Board
  module UseCases
    class CreateNewFaceUseCase < CreateEntityForWhiteboardUseCase
      def initialize(whiteboard_id:, new_face_repo:, attributes:, observer:)
        super(
          whiteboard_id: whiteboard_id,
          repo: new_face_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::NewFace,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def create_new_face(*args)
      CreateNewFaceUseCase.new(*args)
    end
  end
end
