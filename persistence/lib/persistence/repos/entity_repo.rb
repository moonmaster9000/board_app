module Persistence
  module Repos
    class EntityRepo
      def save(entity)
        entity_record = table_class.new(entity.attributes)
        entity_record.save
        entity.id = entity_record.id
      end

      def find(id)
        entity_record = table_class.find(id)
        entity_from_record(entity_record)
      end

      private

      def entity_from_record(entity_record)
        entity_record_attributes = entity_record.attributes.symbolize_keys.slice(
          *entity_class.attributes
        )

        entity_class.new(entity_record_attributes)
      end
    end
  end
end
