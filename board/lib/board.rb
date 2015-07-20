require "board/use_cases/present_standup_use_case"
require "board/use_cases/create_new_face_use_case"
require "board/use_cases/create_whiteboard_use_case"
require "board/use_cases/present_whiteboard_use_case"
require "board/use_cases/create_help_use_case"
require "board/use_cases/present_whiteboards_use_case"
require "board/use_cases/create_interesting_use_case"
require "board/use_cases/create_event_use_case"
require "board/use_cases/archive_standup_use_case"
require "board/use_cases/present_whiteboard_items_use_case"
require "board/use_cases/email_standup_use_case"
require "board/use_cases/set_standup_email_config_use_case"
require "board/use_cases/authenticate_use_case"

module Board
  extend self

  include UseCases

  def authenticate(*args)
    AuthenticateUseCase.new(*args)
  end

  def archive_standup(*args)
    ArchiveStandupUseCase.new(*args)
  end

  def email_standup_use_case(*args)
    EmailStandupUseCase.new(*args)
  end

  def create_standup_email_config(*args)
    SetStandupEmailConfigUseCase.new(*args)
  end

  def create_whiteboard(*args)
    CreateWhiteboardUseCase.new(*args)
  end

  def create_interesting(*args)
    CreateInterestingUseCase.new(*args)
  end

  def create_event(*args)
    CreateEventUseCase.new(*args)
  end

  def present_whiteboard(*args)
    PresentWhiteboardUseCase.new(*args)
  end

  def create_new_face(*args)
    CreateNewFaceUseCase.new(*args)
  end

  def present_standup(*args)
    PresentStandupUseCase.new(*args)
  end

  def create_help(*args)
    CreateHelpUseCase.new(*args)
  end

  def present_whiteboards(*args)
    PresentWhiteboardsUseCase.new(*args)
  end

  def present_whiteboard_items(*args)
    PresentWhiteboardItemsUseCase.new(*args)
  end
end
