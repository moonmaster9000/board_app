require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "board_test_support/test_attributes"

module BoardTestDsl
  def gui
    @gui ||= GuiSpy.new
  end

  def whiteboard_repo
    repo_factory.whiteboard_repo
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

  def use_case_factory
    @use_cases = Board::UseCaseFactory.new
  end
end

World BoardTestDsl
World TestAttributes

Given(/^there are new faces for my whiteboard$/) do
  use_case_factory.create_whiteboard(
    observer: gui,
    attributes: valid_whiteboard_attributes,
    whiteboard_repo: whiteboard_repo
  ).execute

  use_case_factory.create_new_face(
    observer: gui,
    whiteboard_id: gui.spy_created_whiteboard.id,
    new_face_repo: new_face_repo,
    attributes: valid_new_face_attributes.merge(date: today),
  ).execute
end

When(/^I view my whiteboard's standup$/) do
  use_case_factory.present_standup(
    whiteboard_id: gui.spy_created_whiteboard.id,
    repo_factory: repo_factory,
    observer: gui,
    date: today,
  ).execute
end

Then(/^I should see those new faces$/) do
  expect(gui.spy_presented_standup.new_faces).to include(gui.spy_created_new_face)
end


Given(/^there are helps for my whiteboard$/) do
  use_case_factory.create_whiteboard(
    observer: gui,
    attributes: valid_whiteboard_attributes,
    whiteboard_repo: whiteboard_repo
  ).execute

  use_case_factory.create_help(
    whiteboard_id: gui.spy_created_whiteboard.id,
    attributes: valid_help_attributes.merge(date: today),
    observer: gui,
    help_repo: help_repo,
  ).execute
end

Then(/^I should see those helps$/) do
  expect(gui.spy_presented_standup.helps).to include(gui.spy_created_help)
end

Given(/^there is a whiteboard$/) do
  use_case_factory.create_whiteboard(
      observer: gui,
      attributes: valid_whiteboard_attributes,
      whiteboard_repo: whiteboard_repo
  ).execute
end

When(/^I view a list of whiteboards$/) do
  use_case_factory.present_whiteboards(
      observer: gui,
      whiteboard_repo: whiteboard_repo
  ).execute
end

Then(/^I should see that whiteboard$/) do
  expect(gui.spy_presented_whiteboards).to include(gui.spy_created_whiteboard)
end


Given(/^there are interestings for my whiteboard$/) do
  use_case_factory.create_whiteboard(
    observer: gui,
    attributes: valid_whiteboard_attributes,
    whiteboard_repo: whiteboard_repo
  ).execute

  use_case_factory.create_interesting(
    whiteboard_id: gui.spy_created_whiteboard.id,
    attributes: valid_interesting_attributes.merge(date: today),
    observer: gui,
    interesting_repo: interesting_repo,
  ).execute
end

Then(/^I should see those interestings$/) do
  expect(gui.spy_presented_standup.interestings).to include(gui.spy_created_interesting)
end


Given(/^there are events for my whiteboard$/) do
  use_case_factory.create_whiteboard(
    observer: gui,
    attributes: valid_whiteboard_attributes,
    whiteboard_repo: whiteboard_repo
  ).execute

  use_case_factory.create_event(
    whiteboard_id: gui.spy_created_whiteboard.id,
    attributes: valid_event_attributes.merge(date: today),
    observer: gui,
    event_repo: repo_factory.event_repo,
  ).execute
end

Then(/^I should see those events$/) do
  expect(gui.spy_presented_standup.events).to include(gui.spy_created_event)
end


Given(/^I have posted many things to my whiteboard's standup today$/) do
  use_case_factory.create_whiteboard(
    observer: gui,
    attributes: valid_whiteboard_attributes,
    whiteboard_repo: whiteboard_repo
  ).execute

  use_case_factory.create_new_face(
    whiteboard_id: gui.spy_created_whiteboard.id,
    attributes: valid_new_face_attributes.merge(date: today),
    observer: gui,
    new_face_repo: repo_factory.new_face_repo,
  ).execute
end

When(/^I archive my whiteboard's standup today$/) do
  use_case_factory.archive_standup(
    whiteboard_id: gui.spy_created_whiteboard.id,
    observer: gui,
    repo_factory: repo_factory,
    date: today,
  ).execute
end

Then(/^those items should no longer be on the whiteboard$/) do
  use_case_factory.present_whiteboard_items(
    whiteboard_id: gui.spy_created_whiteboard.id,
    observer: gui,
    repo_factory: repo_factory,
  ).execute

  expect(gui.spy_presented_whiteboard_items.new_faces).to be_empty
end
