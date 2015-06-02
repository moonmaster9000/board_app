require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present New Faces at Standup and on Whiteboard" do
  context "Given there are past, now, and future new faces for my team and another team" do
    before do
      @my_team = create_team
      @another_team = create_team
      @now = Date.today
      @future = @now.next_day
      @past_new_face = create_new_face(team: @my_team, date: @now.prev_day)
      @now_new_face = create_new_face(team: @my_team, date: @now)
      @future_new_face = create_new_face(team: @my_team, date: @future)
      @other_teams_new_face = create_new_face(team: @another_team, date: @now)
    end

    context "When I present the 'now' standup" do
      before do
        @now_standup = present_standup(team: @my_team, date: @now)
      end

      specify "Then I should see the past and 'now' unarchived new faces" do
        expect(@now_standup.new_faces).to include(@now_new_face, @past_new_face)
      end

      specify "But I should not see future new faces" do
        new_faces = @now_standup.new_faces

        expect(new_faces).not_to include(@future_new_face)
      end

      specify "And I should not see other team's new faces" do
        new_faces = @now_standup.new_faces

        expect(new_faces).not_to include(@other_teams_new_face)
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(team: @my_team)
      end

      specify "Then I should see my team's past, 'now', and future new faces" do
        expect(@now_whiteboard.new_faces).to include(@now_new_face, @past_new_face, @future_new_face)
      end
      
      specify "But I should not see new faces for other teams" do
        expect(@now_whiteboard.new_faces).not_to include(@other_teams_new_face)
      end
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_team.id, @now)
      end

      specify "Then I should not see the past or 'now' new faces on the whiteboard" do
        @now_whiteboard = present_whiteboard(team: @my_team)

        expect(@now_whiteboard.new_faces).not_to include(@past_new_face, @now_new_face)
        expect(@now_whiteboard.new_faces).to include(@future_new_face)
      end

      specify "Then I should not see any new faces on the current standup" do
        present_standup = present_standup(team: @my_team, date: @now)

        expect(present_standup.new_faces).to be_empty
      end

      specify "But I should still new future new faces on the future standup" do
        future_standup = present_standup(team: @my_team, date: @future)

        expect(future_standup.new_faces).to include(@future_new_face)
      end
    end
  end
  
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:help_repo) { repo_factory.help_repo }
  let(:team_repo) { repo_factory.team_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_new_face(team:, date:)
    Board.create_new_face(
      observer: observer,
      attributes: valid_new_face_attributes.merge(date: date),
      new_face_repo: new_face_repo,
      team_id: team.id,
    ).execute

    observer.spy_created_new_face
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
      observer: observer,
      date: date,
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

  def archive_standup(team_id, date)
    Board.archive_standup(
      team_id: team_id,
      date: date,
      repo_factory: repo_factory,
      observer: observer,
    ).execute
  end
end
