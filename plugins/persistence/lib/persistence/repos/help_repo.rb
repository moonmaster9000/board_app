require "board"
require "persistence/private/help"
require "persistence/repos/entity_repo"
require "persistence/repos/lookup_by_whiteboard_and_date"

module Persistence
  module Repos
    class HelpRepo < EntityRepo
      include LookupByWhiteboardAndDate

      def entity_class
        Board::Entities::Help
      end

      def table_class
        Private::Help
      end
    end
  end
end
