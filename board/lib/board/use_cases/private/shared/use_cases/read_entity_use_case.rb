module Board
  module UseCases
    class ReadEntityUseCase
      def initialize(entity_repo:, entity_id:, observer:, entity_name:)
        @entity_repo = entity_repo
        @entity_id = entity_id
        @observer = observer
        @entity_name = entity_name
      end

      def execute
        if entity_exists?
          send_entity_to_observer
        else
          tell_observer_entity_not_found
        end
      end


      private

      def tell_observer_entity_not_found
        @observer.send "#{@entity_name}_not_found"
      end

      def send_entity_to_observer
        @observer.send "#{@entity_name}_read", (entity)
      end


      private

      def entity
        @entity ||= @entity_repo.find(@entity_id)
      end

      def entity_exists?
        !!entity
      end
    end
  end
end
