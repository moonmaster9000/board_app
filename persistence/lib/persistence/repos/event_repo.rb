require "persistence/repos/entity_repo"
require "persistence/private/event"
require "board/entities/event"
require "persistence/repos/lookup_by_team_and_date"

module Persistence
  module Repos
    class EventRepo < EntityRepo
      include LookupByTeamAndDate

      def table_class
        Persistence::Private::Event
      end

      def entity_class
        Board::Entities::Event
      end
    end
  end
end
