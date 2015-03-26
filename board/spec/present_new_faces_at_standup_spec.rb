require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present New Faces at Standup" do
  context "Given there are new faces for my team and another team" do
    before do
      @my_team = create_team
      @new_face_for_my_team= create_new_face(team: @my_team)

      @different_team = create_team
      @new_face_for_different_team = create_new_face(team: @different_team)
    end
    
    context "When I present the standup for my team" do
      before do
        @my_standup = present_standup(team: @my_team)
      end

      specify "Then I should see the new faces for my team" do
        expect(@my_standup.new_faces).to include(@new_face_for_my_team)
      end

      specify "But I should not see new faces for other teams" do
        expect(@my_standup.new_faces).not_to include(@new_face_for_different_team)
      end
    end

    let(:new_face_repo) { repo_factory.new_face_repo }
    let(:help_repo) { repo_factory.help_repo }
    let(:team_repo) { repo_factory.team_repo }
    let(:repo_factory) { FakeRepoFactory.new }

    include TestAttributes
    
    def create_new_face(team:)
      observer = GuiSpy.new 
      
      Board.create_new_face(
        observer: observer,
        attributes: valid_new_face_attributes,
        new_face_repo: new_face_repo,
        team_id: team.id,
      ).execute
      
      observer.spy_created_new_face
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

    def present_standup(team:)
      observer = GuiSpy.new

      Board.present_standup(
        team_id: team.id,
        repo_factory: repo_factory,
        observer: observer,
      ).execute
      
      observer.spy_presented_standup
    end
  end
end
