require "board_test_support/doubles/fake_new_face_repo"
require "board_test_support/doubles/fake_help_repo"
require "board_test_support/doubles/fake_team_repo"

class FakeRepoFactory
  def new_face_repo
    @new_face_repo ||= FakeNewFaceRepo.new
  end

  def help_repo
    @help_repo ||= FakeHelpRepo.new
  end

  def team_repo
    @team_repo ||= FakeTeamRepo.new
  end
end
