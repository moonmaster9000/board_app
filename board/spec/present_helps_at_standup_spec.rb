require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present Helps at Standup" do
  context "Given there are past, present, and future helps for my team" do
    before do
      @my_team = create_team
      @present = Date.today
      @past_help = create_help(team: @my_team, date: @present.prev_day)
      @present_help = create_help(team: @my_team, date: @present)
      @future_help = create_help(team: @my_team, date: @present.next_day)
    end

    context "When I present the standup for the present" do
      before do
        @present_standup = present_standup(team: @my_team, date: @present)
      end

      specify "Then I should see the present help" do
        expect(@present_standup.helps).to include(@present_help)
      end

      specify "But I should not see past or future helps" do
        helps = @present_standup.helps

        expect(helps).not_to include(@past_help)
        expect(helps).not_to include(@future_help)
      end
    end
  end

  context "Given there are helps for my team and another team" do
    before do
      @date = Date.today
      @my_team = create_team
      @help_for_my_team= create_help(team: @my_team, date: @date)

      @different_team = create_team
      @help_for_different_team = create_help(team: @different_team, date: @date)
    end
    
    context "When I present the standup for my team" do
      before do
        @my_standup = present_standup(team: @my_team, date: @date)
      end

      specify "Then I should see the helps for my team" do
        expect(@my_standup.helps).to include(@help_for_my_team)
      end

      specify "But I should not see helps for other teams" do
        expect(@my_standup.helps).not_to include(@help_for_different_team)
      end
    end
  end

  let(:help_repo) { repo_factory.help_repo }
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:team_repo) { repo_factory.team_repo }
  let(:repo_factory) { FakeRepoFactory.new }

  include TestAttributes

  def create_help(team:, date:)
    observer = GuiSpy.new

    Board.create_help(
      observer: observer,
      attributes: valid_help_attributes.merge(date: date),
      help_repo: help_repo,
      team_id: team.id,
    ).execute

    observer.spy_created_help
  end

  def create_team
    observer = GuiSpy.new

    Board.create_team(
      observer: observer,
      attributes: valid_team_attributes,
      team_repo: team_repo,
    ).execute

    observer.spy_created_team
  end

  def present_standup(team:, date:)
    observer = GuiSpy.new

    Board.present_standup(
      team_id: team.id,
      repo_factory: repo_factory,
      date: date,
      observer: observer,
    ).execute

    observer.spy_presented_standup
  end
end
