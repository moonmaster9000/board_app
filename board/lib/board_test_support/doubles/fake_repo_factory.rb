require "board_test_support/doubles/fake_new_face_repo"
require "board_test_support/doubles/fake_help_repo"
require "board_test_support/doubles/fake_interesting_repo"
require "board_test_support/doubles/fake_whiteboard_repo"
require "board_test_support/doubles/fake_event_repo"
require "board_test_support/doubles/fake_standup_email_config_repo"
require "board_test_support/doubles/fake_post_repo"

class FakeRepoFactory
  def post_repo
    @post_repo ||= FakePostRepo.new
  end

  def new_face_repo
    @new_face_repo ||= FakeNewFaceRepo.new
  end

  def help_repo
    @help_repo ||= FakeHelpRepo.new
  end

  def whiteboard_repo
    @whiteboard_repo ||= FakeWhiteboardRepo.new
  end

  def standup_email_config_repo
    @standup_email_config_repo ||= FakeStandupEmailConfigRepo.new
  end

  def event_repo
    @event_repo ||= FakeEventRepo.new
  end

  def interesting_repo
    @interesting_repo ||= FakeInterestingRepo.new
  end
end

