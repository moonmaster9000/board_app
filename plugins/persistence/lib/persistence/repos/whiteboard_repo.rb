require "board"
require "persistence/private/whiteboard"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class WhiteboardRepo < EntityRepo
      def entity_class
        Board::Entities::Whiteboard
      end

      def table_class
        Private::Whiteboard
      end
    end
  end
end
