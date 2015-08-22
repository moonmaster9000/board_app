require "board/use_cases/read_entity_use_case"
require "board/use_cases/new_faces/entities/new_face"

module Board
  module UseCases
    class ReadNewFaceUseCase < ReadEntityUseCase
      def initialize(repo_factory:, new_face_id:, observer:)
        super(
          entity_repo: repo_factory.new_face_repo,
          entity_id: new_face_id,
          observer: observer,
          entity_name: :new_face,
        )
      end
    end
  end
end

require "board/use_case_factory"

module Board
  class UseCaseFactory
    def read_new_face(*args)
      ReadNewFaceUseCase.new(*args)
    end
  end
end
