require 'board'
require 'board_test_support/doubles/gui_spy'
require 'board_test_support/doubles/fake_team_repo'
require 'board_test_support/test_attributes'

module BoardTestDsl
  def gui
    @gui ||= GuiSpy.new
  end

  def team_repo
    @team_repo ||= FakeTeamRepo.new
  end
end

World BoardTestDsl
World TestAttributes

Given(/^there are new faces for my team$/) do
  Board.create_team(observer: gui, attributes: valid_team_attributes, team_repo: team_repo).execute
  Board.create_new_face(observer: gui, team_id: gui.spy_created_team.id).execute
end

When(/^I view my team's standup$/) do
  Board.present_standup(team_id: gui.created_team.id).execute
end

Then(/^I should see those new faces$/) do
  expect(gui.presented_standup.new_faces).to include(gui.created_new_face)
end
