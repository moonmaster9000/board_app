require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/doubles/fake_new_face_repo"
require "board_test_support/doubles/fake_help_repo"
require "board_test_support/test_attributes"

module BoardTestDsl
  def gui
    @gui ||= GuiSpy.new
  end

  def team_repo
    @team_repo ||= FakeTeamRepo.new
  end

  def help_repo
    @help_repo ||= FakeHelpRepo.new
  end

  def new_face_repo
    @new_face_repo ||= FakeNewFaceRepo.new
  end
end

World BoardTestDsl
World TestAttributes

Given(/^there are new faces for my team$/) do
  Board.create_team(
    observer: gui,
    attributes: valid_team_attributes,
    team_repo: team_repo
  ).execute

  Board.create_new_face(
    observer: gui,
    team_id: gui.spy_created_team.id,
    new_face_repo: new_face_repo,
    attributes: valid_new_face_attributes,
  ).execute
end

When(/^I view my team's standup$/) do
  Board.present_standup(
    team_id: gui.spy_created_team.id,
    new_face_repo: new_face_repo,
    observer: gui,
  ).execute
end

Then(/^I should see those new faces$/) do
  expect(gui.spy_presented_standup.new_faces).to include(gui.spy_created_new_face)
end


Given(/^there are helps for my team$/) do
  Board.create_team(
    observer: gui,
    attributes: valid_team_attributes,
    team_repo: team_repo
  ).execute

  Board.create_help(
    team_id: gui.spy_created_team.id,
    attributes: { author: "valid author", date: valid_date, description: "valid description" },
    observer: gui,
    help_repo: help_repo,
  ).execute
end

Then(/^I should see those helps$/) do
  expect(gui.spy_presented_standup.helps).to include(gui.spy_created_help)
end
