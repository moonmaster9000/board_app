require "board"
require "persistence/repos/entity_repo"
require "persistence/private/interesting"
require "persistence/repos/lookup_by_whiteboard_and_date"

module Persistence
  module Repos
    class InterestingRepo < EntityRepo
      include LookupByWhiteboardAndDate

      def table_class
        Persistence::Private::Interesting
      end

      def entity_class
        Board::Entities::Interesting
      end
    end
  end
end
