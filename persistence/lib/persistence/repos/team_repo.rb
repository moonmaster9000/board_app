require "board/entities/whiteboard"
require "persistence/private/team"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class TeamRepo < EntityRepo
      def entity_class
        Board::Entities::Team
      end

      def table_class
        Private::Team
      end
    end
  end
end
