module Persistence
  module Repos
    module LookupByTeamAndDate
      def all_by_team_id_and_date(team_id, date)
        entity_records = table_class.where(team_id: team_id).where(date: date)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end
    end
  end
end
