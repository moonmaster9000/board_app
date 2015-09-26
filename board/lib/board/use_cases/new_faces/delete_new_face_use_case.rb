require "board/use_cases/private/use_cases/delete_entity_use_case"
require "board/use_cases/new_faces/entities/new_face"

module Board
  module UseCases
    class DeleteNewFaceUseCase < DeleteEntityUseCase
      def initialize(new_face_id:, repo_factory:, observer:)
        super(
          entity_id: new_face_id,
          observer: observer,
          repo: repo_factory.new_face_repo,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def delete_new_face(*args)
      UseCases::DeleteNewFaceUseCase.new(*args)
    end
  end
end
