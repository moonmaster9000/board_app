require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present Helps at Standup" do
  context "Given there are past, now, and future helps for my team" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_team = create_team
      @past_help = create_help(team: @my_team, date: @past)
      @now_help = create_help(team: @my_team, date: @now)
      @future_help = create_help(team: @my_team, date: @future)

      @different_team = create_team
      @help_for_different_team = create_help(team: @different_team, date: @now)
    end

    context "When I present the standup for the 'now'" do
      before do
        @now_standup = present_standup(team: @my_team, date: @now)
      end

      specify "Then I should see the past and 'now' helps" do
        expect(@now_standup.helps).to include(@past_help, @now_help)
      end

      specify "But I should not see future helps" do
        expect(@now_standup.helps).not_to include(@future_help)
      end
      
      specify "And I should not see other team helps" do
        expect(@now_standup.helps).not_to include @help_for_different_team
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(team: @my_team)
      end

      specify "Then I should see my team's past, 'now', and future helps" do
        expect(@now_whiteboard.helps).to include(@now_help, @past_help, @future_help)
      end

      specify "But I should not see helps for other teams" do
        expect(@now_whiteboard.helps).not_to include(@help_for_different_team)
      end
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_team.id, @now)
      end

      specify "Then I should not see the past or 'now' helps on the whiteboard" do
        @now_whiteboard = present_whiteboard(team: @my_team)

        expect(@now_whiteboard.helps).not_to include(@past_help, @now_help)
        expect(@now_whiteboard.helps).to include(@future_help)
      end

      specify "Then I should not see any helps on the current standup" do
        present_standup = present_standup(team: @my_team, date: @now)

        expect(present_standup.helps).to be_empty
      end

      specify "But I should still new future helps on the future standup" do
        future_standup = present_standup(team: @my_team, date: @future)

        expect(future_standup.helps).to include(@future_help)
      end
    end
    
  end

  let(:help_repo) { repo_factory.help_repo }
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:team_repo) { repo_factory.team_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_help(team:, date:)
    Board.create_help(
      observer: observer,
      attributes: valid_help_attributes.merge(date: date),
      help_repo: help_repo,
      team_id: team.id,
    ).execute

    observer.spy_created_help
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
    Board.present_whiteboard_items(
      team_id: team.id,
      repo_factory: repo_factory,
      observer: observer,
    ).execute

    observer.spy_presented_whiteboard_items
  end
end
