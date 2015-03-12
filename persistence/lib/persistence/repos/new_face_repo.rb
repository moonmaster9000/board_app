require "board/entities/new_face"
require "persistence/private/new_face"
require "persistence/repos/entity_repo"

module Persistence
  module Repos
    class NewFaceRepo < EntityRepo
      def entity_class
        Board::Entities::NewFace
      end

      def table_class
        Private::NewFace
      end

      def all_by_team_id(team_id)
        entity_records = table_class.where(team_id: team_id)
        entity_records.map { |entity_record| entity_from_record(entity_record) }
      end
    end
  end
end
