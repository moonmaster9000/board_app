require "board/entities/help"
require "persistence/private/help"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class HelpRepo < EntityRepo
      def entity_class
        Board::Entities::Help
      end

      def table_class
        Private::Help
      end

      def all_by_team_id(team_id)
        entity_records = table_class.where(team_id: team_id)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end
    end
  end
end
