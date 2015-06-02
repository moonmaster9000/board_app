module Board
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
