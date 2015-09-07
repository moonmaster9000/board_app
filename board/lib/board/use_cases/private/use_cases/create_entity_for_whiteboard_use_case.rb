require "board/use_cases/private/utilities/string_extensions"

module Board
  module UseCases
    class CreateEntityForWhiteboardUseCase
      def initialize(attributes:, repo:, observer:, whiteboard_id:, entity_class:)
        @observer = observer
        @repo = repo
        @attributes = attributes
        @whiteboard_id = whiteboard_id
        @entity_class = entity_class
      end

      def execute
        if request_valid?
          persist
          send_presentable_entity_to_observer
        else
          send_validation_errors_to_observer
        end
      end

      private

      def send_validation_errors_to_observer
        @observer.validation_failed(entity.validation_errors)
      end

      def send_presentable_entity_to_observer
        @observer.send creation_succeeded_method_name, entity
      end

      def persist
        @repo.save(entity)
      end

      def request_valid?
        entity.valid?
      end

      def entity
        @entity ||= @entity_class.new(@attributes.merge(whiteboard_id: @whiteboard_id))
      end

      def creation_succeeded_method_name
        "#{entity_name}_created"
      end

      def entity_name
        @entity_name ||= StringExtensions.turn_camelcase_into_snakecase(@entity_class.name)
      end
    end
  end
end
