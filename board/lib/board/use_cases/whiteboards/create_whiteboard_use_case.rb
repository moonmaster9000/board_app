require "board/use_cases/whiteboards/entities/whiteboard"

module Board
  module UseCases
    class CreateWhiteboardUseCase
      def initialize(observer:, attributes:, whiteboard_repo:)
        @observer = observer
        @whiteboard_repo = whiteboard_repo
        @attributes = attributes
      end

      def execute
        if valid?
          persist
          notify_observer_of_success
        else
          notify_observer_of_failures
        end
      end

      def notify_observer_of_success
        @observer.whiteboard_created(whiteboard)
      end

      def persist
        @whiteboard_repo.save(whiteboard)
      end

      def whiteboard
        @whiteboard ||= Entities::Whiteboard.new(@attributes)
      end

      def notify_observer_of_failures
        @observer.validation_failed(whiteboard.validation_errors)
      end

      def valid?
        whiteboard.valid?
      end
    end
  end
end

module Board
  class UseCaseFactory
    def create_whiteboard(*args)
      UseCases::CreateWhiteboardUseCase.new(*args)
    end
  end
end
