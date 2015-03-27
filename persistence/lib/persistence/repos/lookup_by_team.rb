module Persistence
  module Repos
    module LookupByTeam
      def all_by_team_id(team_id)
        entity_records = table_class.where(team_id: team_id)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end
    end
  end
end
