module Board
  module UseCases
    class DeleteEntityUseCase
      def initialize(repo:, observer:, entity_id:)
        @entity_id = entity_id
        @observer = observer
        @repo = repo
      end

      def execute
        if entity_not_found?
          notify_observer_entity_not_found
        else
          delete_entity
          notify_observer_of_success
        end
      end

      private

      def notify_observer_of_success
        @observer.delete_succeeded
      end

      def notify_observer_entity_not_found
        @observer.entity_not_found
      end

      def delete_entity
        @repo.delete(@entity_id)
      end

      def entity_not_found?
        @repo.find(@entity_id).nil?
      end
    end
  end
end
