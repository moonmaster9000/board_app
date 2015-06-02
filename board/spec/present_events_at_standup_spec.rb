require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present Events at Standup" do
  context "Given there are past, now, and future events for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_event = create_event(whiteboard: @my_whiteboard, date: @past)
      @now_event = create_event(whiteboard: @my_whiteboard, date: @now)
      @future_event = create_event(whiteboard: @my_whiteboard, date: @future)

      @different_whiteboard = create_whiteboard
      @event_for_different_whiteboard = create_event(whiteboard: @different_whiteboard, date: @now)
    end

    context "When I present the standup for the 'now'" do
      before do
        @now_standup = present_standup(whiteboard: @my_whiteboard, date: @now)
      end

      specify "Then I should see my whiteboard's past, 'now', and future events" do
        expect(@now_standup.events).to include(@past_event, @now_event, @future_event)
      end

      specify "But I should not see other whiteboard events" do
        expect(@now_standup.events).not_to include @event_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)
      end

      specify "Then I should see my whiteboard's past, 'now', and future events" do
        expect(@now_whiteboard.events).to include(@now_event, @past_event, @future_event)
      end

      specify "But I should not see events for other whiteboards" do
        expect(@now_whiteboard.events).not_to include(@event_for_different_whiteboard)
      end
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' events on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)

        expect(@now_whiteboard.events).not_to include(@past_event, @now_event)
        expect(@now_whiteboard.events).to include(@future_event)
      end

      specify "And I should not see the past or 'now' events on the standup" do
        now_standup_events = present_standup(whiteboard: @my_whiteboard, date: @now).events

        expect(now_standup_events).not_to include(@past_event, @now_event)
        expect(now_standup_events).to include(@future_event)
      end

      specify "But I should still see future events on the future standup" do
        future_standup = present_standup(whiteboard: @my_whiteboard, date: @future)

        expect(future_standup.events).to include(@future_event)
      end
    end
  end

  let(:event_repo) { repo_factory.event_repo }
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:whiteboard_repo) { repo_factory.whiteboard_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_event(whiteboard:, date:)
    Board.create_event(
      observer: observer,
      attributes: valid_event_attributes.merge(date: date),
      event_repo: event_repo,
      whiteboard_id: whiteboard.id,
    ).execute

    observer.spy_created_event
  end

  def archive_standup(whiteboard_id, date)
    Board.archive_standup(
      observer: observer,
      repo_factory: repo_factory,
      whiteboard_id: whiteboard_id,
      date: date,
    ).execute
  end

  def create_whiteboard
    Board.create_whiteboard(
      observer: observer,
      attributes: valid_whiteboard_attributes,
      whiteboard_repo: whiteboard_repo,
    ).execute

    observer.spy_created_whiteboard
  end

  def present_standup(whiteboard:, date:)
    Board.present_standup(
      whiteboard_id: whiteboard.id,
      repo_factory: repo_factory,
      date: date,
      observer: observer,
    ).execute

    observer.spy_presented_standup
  end

  def present_whiteboard(whiteboard:)
    Board.present_whiteboard_items(
      whiteboard_id: whiteboard.id,
      repo_factory: repo_factory,
      observer: observer,
    ).execute

    observer.spy_presented_whiteboard_items
  end
end
