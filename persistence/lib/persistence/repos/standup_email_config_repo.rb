require "board/entities/standup_email_config"
require "persistence/private/standup_email_config"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class StandupEmailConfigRepo < EntityRepo
      def find_by_whiteboard_id(whiteboard_id)
        entity_from_record table_class.where(whiteboard_id: whiteboard_id).first
      end

      def entity_class
        Board::Entities::StandupEmailConfig
      end

      def table_class
        Private::StandupEmailConfig
      end
    end
  end
end
