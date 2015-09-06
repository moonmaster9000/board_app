require "board/use_cases/update_entity_for_whiteboard_use_case"
require "board/use_cases/new_faces/entities/new_face"

module Board
  module UseCases
    class UpdateNewFaceUseCase < UpdateEntityForWhiteboardUseCase
      def initialize(new_face_id:, repo_factory:, attributes:, observer:)
        super(
          entity_id: new_face_id,
          repo: repo_factory.new_face_repo,
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
    def update_new_face(*args)
      UseCases::UpdateNewFaceUseCase.new(*args)
    end
  end
end
