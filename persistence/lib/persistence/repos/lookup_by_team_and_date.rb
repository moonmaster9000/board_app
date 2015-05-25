module Persistence
  module Repos
    module LookupByTeamAndDate
      def all_by_team_id_and_date(team_id, date)
        hydrate_entities(all_by_team_id_query(team_id).where(date: date))
      end

      def all_by_team_id(team_id)
        hydrate_entities(all_by_team_id_query(team_id))
      end

      def unarchived_by_team_id_on_or_before_date(team_id, date)
        hydrate_entities(unarchived_by_team_id_query(team_id).where(
          table_class.arel_table[:date].lteq(date)
        ))
      end

      def unarchived_by_team_id(team_id)
        hydrate_entities(
          unarchived_by_team_id_query(team_id)
        )
      end

      private
      def unarchived_by_team_id_query(team_id)
        all_by_team_id_query(team_id).where(
          table_class.arel_table[:archived].eq(false)
        )
      end

      def hydrate_entities(entity_records)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end

      def all_by_team_id_query(team_id)
        table_class.where(team_id: team_id)
      end
    end
  end
end
