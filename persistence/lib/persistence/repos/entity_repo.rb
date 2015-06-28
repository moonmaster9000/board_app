module Persistence
  module Repos
    class EntityRepo
      def save(entity)
        if entity.id
          entity_record = table_class.find(entity.id)
          entity_record.update_attributes(entity.attributes)
        else
          entity_record = table_class.new(entity.attributes)
          entity_record.save
        end

        entity.id = entity_record.id
      end

      def find(id)
        entity_record = table_class.find(id)
        entity_from_record(entity_record)
      end

      def all
        entity_records = table_class.all
        entity_records.map { |entity_record| entity_from_record(entity_record) }
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
