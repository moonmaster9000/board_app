module Board
  module UseCases
    class PresentWhiteboardsUseCase
      def initialize(observer:,whiteboard_repo:)
        @observer = observer
        @whiteboard_repo = whiteboard_repo
      end

      def execute
        whiteboards = @whiteboard_repo.all
        @observer.whiteboards_presented(whiteboards)
      end
    end
  end
end

module Board
  class UseCaseFactory
    def present_whiteboards(*args)
      UseCases::PresentWhiteboardsUseCase.new(*args)
    end
  end
end
