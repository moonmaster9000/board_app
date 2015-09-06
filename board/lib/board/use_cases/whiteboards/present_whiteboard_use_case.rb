module Board
  module UseCases
    class PresentWhiteboardUseCase
      def initialize(observer:, whiteboard_id:, whiteboard_repo:)
        @whiteboard_repo = whiteboard_repo
        @observer = observer
        @whiteboard_id = whiteboard_id
      end

      def execute
        whiteboard = @whiteboard_repo.find(@whiteboard_id)
        @observer.whiteboard_presented(whiteboard)
      end
    end
  end
end

module Board
  class UseCaseFactory
    def present_whiteboard(*args)
      UseCases::PresentWhiteboardUseCase.new(*args)
    end
  end
end

