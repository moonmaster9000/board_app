require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present Events at Standup" do
  context "Given there are past, now, and future events for my team" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_team = create_team
      @past_event = create_event(team: @my_team, date: @past)
      @now_event = create_event(team: @my_team, date: @now)
      @future_event = create_event(team: @my_team, date: @future)

      @different_team = create_team
      @event_for_different_team = create_event(team: @different_team, date: @now)
    end

    context "When I present the standup for the 'now'" do
      before do
        @now_standup = present_standup(team: @my_team, date: @now)
      end

      specify "Then I should see my team's past, 'now', and future events" do
        expect(@now_standup.events).to include(@past_event, @now_event, @future_event)
      end

      specify "But I should not see other team events" do
        expect(@now_standup.events).not_to include @event_for_different_team
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(team: @my_team)
      end

      specify "Then I should see my team's past, 'now', and future events" do
        expect(@now_whiteboard.events).to include(@now_event, @past_event, @future_event)
      end

      specify "But I should not see events for other teams" do
        expect(@now_whiteboard.events).not_to include(@event_for_different_team)
      end
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_team.id, @now)
      end

      specify "Then I should not see the past or 'now' events on the whiteboard" do
        @now_whiteboard = present_whiteboard(team: @my_team)

        expect(@now_whiteboard.events).not_to include(@past_event, @now_event)
        expect(@now_whiteboard.events).to include(@future_event)
      end

      specify "And I should not see the past or 'now' events on the standup" do
        now_standup_events = present_standup(team: @my_team, date: @now).events

        expect(now_standup_events).not_to include(@past_event, @now_event)
        expect(now_standup_events).to include(@future_event)
      end

      specify "But I should still see future events on the future standup" do
        future_standup = present_standup(team: @my_team, date: @future)

        expect(future_standup.events).to include(@future_event)
      end
    end
  end

  let(:event_repo) { repo_factory.event_repo }
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:team_repo) { repo_factory.team_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_event(team:, date:)
    Board.create_event(
      observer: observer,
      attributes: valid_event_attributes.merge(date: date),
      event_repo: event_repo,
      team_id: team.id,
    ).execute

    observer.spy_created_event
  end

  def archive_standup(team_id, date)
    Board.archive_standup(
      observer: observer,
      repo_factory: repo_factory,
      team_id: team_id,
      date: date,
    ).execute
  end

  def create_team
    Board.create_team(
      observer: observer,
      attributes: valid_team_attributes,
      team_repo: team_repo,
    ).execute

    observer.spy_created_team
  end

  def present_standup(team:, date:)
    Board.present_standup(
      team_id: team.id,
      repo_factory: repo_factory,
      date: date,
      observer: observer,
    ).execute

    observer.spy_presented_standup
  end

  def present_whiteboard(team:)
    Board.present_whiteboard(
      team_id: team.id,
      repo_factory: repo_factory,
      observer: observer,
    ).execute

    observer.spy_presented_whiteboard
  end
end
