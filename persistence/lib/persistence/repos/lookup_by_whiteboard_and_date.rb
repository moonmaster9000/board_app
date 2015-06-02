module Persistence
  module Repos
    module LookupByWhiteboardAndDate
      def all_by_whiteboard_id_and_date(whiteboard_id, date)
        hydrate_entities(all_by_whiteboard_id_query(whiteboard_id).where(date: date))
      end

      def all_by_whiteboard_id(whiteboard_id)
        hydrate_entities(all_by_whiteboard_id_query(whiteboard_id))
      end

      def unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date)
        hydrate_entities(unarchived_by_whiteboard_id_query(whiteboard_id).where(
          table_class.arel_table[:date].lteq(date)
        ))
      end

      def unarchived_by_whiteboard_id(whiteboard_id)
        hydrate_entities(
          unarchived_by_whiteboard_id_query(whiteboard_id)
        )
      end

      private
      def unarchived_by_whiteboard_id_query(whiteboard_id)
        all_by_whiteboard_id_query(whiteboard_id).where(
          table_class.arel_table[:archived].eq(false)
        )
      end

      def hydrate_entities(entity_records)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end

      def all_by_whiteboard_id_query(whiteboard_id)
        table_class.where(whiteboard_id: whiteboard_id)
      end
    end
  end
end
