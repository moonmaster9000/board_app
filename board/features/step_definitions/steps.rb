require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "board_test_support/test_attributes"

module BoardTestDsl
  def gui
    @gui ||= GuiSpy.new
  end

  def team_repo
    repo_factory.team_repo
  end

  def help_repo
    repo_factory.help_repo
  end

  def new_face_repo
    repo_factory.new_face_repo
  end

  def interesting_repo
    repo_factory.interesting_repo
  end

  def repo_factory
    @repo_factory ||= FakeRepoFactory.new
  end

  def today
    @today ||= Date.today
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
    attributes: valid_new_face_attributes.merge(date: today),
  ).execute
end

When(/^I view my team's standup$/) do
  Board.present_standup(
    team_id: gui.spy_created_team.id,
    repo_factory: repo_factory,
    observer: gui,
    date: today,
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
    attributes: valid_help_attributes.merge(date: today),
    observer: gui,
    help_repo: help_repo,
  ).execute
end

Then(/^I should see those helps$/) do
  expect(gui.spy_presented_standup.helps).to include(gui.spy_created_help)
end

Given(/^there is a team$/) do
  Board.create_team(
      observer: gui,
      attributes: valid_team_attributes,
      team_repo: team_repo
  ).execute
end

When(/^I view a list of teams$/) do
  Board.present_teams(
      observer: gui,
      team_repo: team_repo
  ).execute
end

Then(/^I should see that team$/) do
  expect(gui.spy_presented_teams).to include(gui.spy_created_team)
end


Given(/^there are interestings for my team$/) do
  Board.create_team(
    observer: gui,
    attributes: valid_team_attributes,
    team_repo: team_repo
  ).execute

  Board.create_interesting(
    team_id: gui.spy_created_team.id,
    attributes: valid_interesting_attributes.merge(date: today),
    observer: gui,
    interesting_repo: interesting_repo,
  ).execute
end

Then(/^I should see those interestings$/) do
  expect(gui.spy_presented_standup.interestings).to include(gui.spy_created_interesting)
end


Given(/^there are events for my team$/) do
  Board.create_team(
    observer: gui,
    attributes: valid_team_attributes,
    team_repo: team_repo
  ).execute

  Board.create_event(
    team_id: gui.spy_created_team.id,
    attributes: valid_event_attributes.merge(date: today),
    observer: gui,
    event_repo: repo_factory.event_repo,
  ).execute
end

Then(/^I should see those events$/) do
  expect(gui.spy_presented_standup.events).to include(gui.spy_created_event)
end


Given(/^I have posted many things to my team's standup today$/) do
  Board.create_team(
    observer: gui,
    attributes: valid_team_attributes,
    team_repo: team_repo
  ).execute

  Board.create_new_face(
    team_id: gui.spy_created_team.id,
    attributes: valid_new_face_attributes.merge(date: today),
    observer: gui,
    new_face_repo: repo_factory.new_face_repo,
  ).execute
end

When(/^I archive my team's standup today$/) do
  Board.archive_standup(
    team_id: gui.spy_created_team.id,
    observer: gui,
    repo_factory: repo_factory,
    date: today,
  ).execute
end

Then(/^those items should no longer be on the whiteboard$/) do
  Board.present_whiteboard(
    team_id: gui.spy_created_team.id,
    observer: gui,
    repo_factory: repo_factory,
  ).execute

  expect(gui.spy_presented_whiteboard.new_faces).to be_empty
end
