require "board/entities/new_face"
require "persistence/private/new_face"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class NewFaceRepo < EntityRepo
      def entity_class
        Board::Entities::NewFace
      end

      def table_class
        Private::NewFace
      end
    end
  end
end
