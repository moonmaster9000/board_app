require "board/entities/team"
require "persistence/private/team"

module Persistence
  module Repos
    class TeamRepo
      def save(team)
        team_record = Private::Team.new(team.attributes)
        team_record.save
        Board::Entities::Team.new(team_record.attributes)
      end
    end
  end
end
