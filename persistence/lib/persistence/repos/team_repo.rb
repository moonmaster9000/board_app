require "board/entities/team"
require "persistence/private/team"

module Persistence
  module Repos
    class TeamRepo
      def save(team)
        team_record = Private::Team.new(team.attributes)
        team_record.save
        team.id = team_record.id
      end

      def find(id)
        team_record = Private::Team.find(id)
        entity_from_record(team_record)
      end

      private

      def entity_from_record(team_record)
        team_record_attributes = team_record.attributes.symbolize_keys.slice(
          *Board::Entities::Team.attributes
        )

        Board::Entities::Team.new(team_record_attributes)
      end
    end
  end
end
