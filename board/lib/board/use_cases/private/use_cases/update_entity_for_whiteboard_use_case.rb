require "board/use_cases/private/utilities/string_extensions"

module Board
  module UseCases
    class UpdateEntityForWhiteboardUseCase
      def initialize(attributes:, repo:, observer:, entity_id:, entity_class:)
        @observer = observer
        @repo = repo
        @attributes = attributes
        @entity_class = entity_class
        @entity_id = entity_id
      end

      def execute
        if entity_not_found?
          notify_observer_entity_not_found
        else
          update_entity
        end
      end

      private

      def update_entity
        if request_valid?
          persist
          send_presentable_entity_to_observer
        else
          send_validation_errors_to_observer
        end
      end

      def notify_observer_entity_not_found
        @observer.entity_not_found
      end

      def entity_not_found?
        existing_entity.nil?
      end

      def send_validation_errors_to_observer
        @observer.validation_failed(entity.validation_errors)
      end

      def send_presentable_entity_to_observer
        @observer.send edit_succeeded_method_name, entity
      end

      def persist
        @repo.save(entity)
      end

      def request_valid?
        entity.valid?
      end

      def entity
        @entity ||= begin
          old_attributes = existing_entity.attributes
          @entity_class.new(old_attributes.merge(@attributes))
        end
      end

      def existing_entity
        @repo.find(@entity_id)
      end

      def edit_succeeded_method_name
        "#{entity_name}_updated"
      end

      def entity_name
        @entity_name ||= StringExtensions.turn_camelcase_into_snakecase(@entity_class.name)
      end
    end
  end
end
