require "board/use_cases/standups/entities/standup_email_config"
require "persistence/private/standup_email_config"

module Persistence
  module Repos
    class StandupEmailConfigRepo
      def set(config)
        config_record = table_class.where(whiteboard_id: config.whiteboard_id).first_or_initialize
        new_attributes = mass_assignable_attributes(config)
        config_record.update_attributes(new_attributes)
        config_record.save
        config.id = config_record.id
      end

      def find_by_whiteboard_id(whiteboard_id)
        entity_from_record find_record_by_whiteboard_id(whiteboard_id)
      end


      private

      def find_record_by_whiteboard_id(whiteboard_id)
        table_class.where(whiteboard_id: whiteboard_id).first
      end

      def mass_assignable_attributes(config)
        config.attributes.select { |k, _| k.to_s != "id" }
      end

      def entity_class
        Board::Entities::StandupEmailConfig
      end

      def table_class
        Private::StandupEmailConfig
      end

      def entity_from_record(entity_record)
        return nil if entity_record.nil?

        entity_record_attributes = entity_record.attributes.symbolize_keys.slice(
          *entity_class.attributes
        )

        entity_class.new(entity_record_attributes)
      end
    end
  end
end
