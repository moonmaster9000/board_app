require "board"
require "persistence/repos/lookup_by_whiteboard_and_date"
require "persistence/private/new_face"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class NewFaceRepo < EntityRepo
      include LookupByWhiteboardAndDate

      def entity_class
        Board::Entities::NewFace
      end

      def table_class
        Private::NewFace
      end
    end
  end
end
