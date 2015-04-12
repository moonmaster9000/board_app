require "board/use_cases/present_standup_use_case"
require "board/use_cases/create_new_face_use_case"
require "board/use_cases/create_team_use_case"
require "board/use_cases/present_team_use_case"
require "board/use_cases/create_help_use_case"
require "board/use_cases/present_teams_use_case"

module Board
  extend self

  include UseCases

  def create_team(*args)
    CreateTeamUseCase.new(*args)
  end

  def present_team(*args)
    PresentTeamUseCase.new(*args)
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

  def present_teams(*args)
    PresentTeamsUseCase.new(*args)
  end
end
