require "board/entities/help"
require "persistence/private/help"
require "persistence/repos/entity_repo"
require "persistence/repos/lookup_by_team"

module Persistence
  module Repos
    class HelpRepo < EntityRepo
      include LookupByTeam

      def entity_class
        Board::Entities::Help
      end

      def table_class
        Private::Help
      end
    end
  end
end
