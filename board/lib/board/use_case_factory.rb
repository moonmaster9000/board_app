Dir[File.join(__dir__, "use_cases", "**", "*_use_case.rb")].each do |use_case|
  require use_case
end

module Board
  class UseCaseFactory
    include UseCases

    def post_standup_to_blog(*args)
      PostStandupToBlogUseCase.new(*args)
    end

    def archive_standup(*args)
      ArchiveStandupUseCase.new(*args)
    end

    def email_standup(*args)
      EmailStandupUseCase.new(*args)
    end

    def create_standup_email_config(*args)
      SetStandupEmailConfigUseCase.new(*args)
    end

    def create_whiteboard(*args)
      CreateWhiteboardUseCase.new(*args)
    end

    def present_whiteboard(*args)
      PresentWhiteboardUseCase.new(*args)
    end

    def present_standup(*args)
      PresentStandupUseCase.new(*args)
    end

    def present_whiteboards(*args)
      PresentWhiteboardsUseCase.new(*args)
    end

    def present_whiteboard_items(*args)
      PresentWhiteboardItemsUseCase.new(*args)
    end
  end
end
