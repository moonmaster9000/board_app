module Board
  class UseCaseFactory

  end
end

Dir[File.join(__dir__, "use_cases", "**", "*_use_case.rb")].each do |use_case|
  require use_case
end

module Board
  class UseCaseFactory
    include UseCases

    def create_whiteboard(*args)
      CreateWhiteboardUseCase.new(*args)
    end

    def present_whiteboard(*args)
      PresentWhiteboardUseCase.new(*args)
    end

    def present_whiteboards(*args)
      PresentWhiteboardsUseCase.new(*args)
    end

    def present_whiteboard_items(*args)
      PresentWhiteboardItemsUseCase.new(*args)
    end
  end
end
