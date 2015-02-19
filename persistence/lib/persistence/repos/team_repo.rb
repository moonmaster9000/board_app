require "board/entities/team"
require "persistence/private/team"

module Persistence
  module Repos
    class TeamRepo
      def save(team)
        team_record = Private::Team.new(team.attributes)

        team_record.save

        team_record_attributes = team_record.attributes.symbolize_keys.slice(
          *team.attributes.keys
        )

        Board::Entities::Team.new(
          team_record_attributes
        )
      end
    end
  end
end
