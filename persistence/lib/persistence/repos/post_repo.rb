require "persistence/repos/entity_repo"
require "persistence/private/post"

module Persistence
  module Repos
    class PostRepo < EntityRepo
      def find_by_whiteboard_id_and_standup_date(whiteboard_id, standup_date)
        entity_from_record table_class.where(whiteboard_id: whiteboard_id, standup_date: standup_date).first
      end

      private

      def table_class
        Persistence::Private::Post
      end

      def entity_class
        Board::Entities::Post
      end
    end
  end
end
