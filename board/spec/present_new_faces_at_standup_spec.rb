require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_new_face_repo"
require "board_test_support/doubles/fake_team_repo"

describe "USE CASE: Present New Faces at Standup" do
  include TestAttributes

  context "Given there are new faces for a team" do
    before do
      create_team(observer:observer1)
      create_new_face(observer:observer1, team: team1)
    end

    context "When I present the standup for that team" do
      before do
        present_standup(team: team1, observer: observer1)
      end

      specify "Then I should see those new faces for that team" do
        expect(presented_new_faces(observer1)).to include(created_new_face(observer1))
      end

      specify "But I should not see new faces for other teams" do
        create_team(observer:observer2)
        create_new_face(observer:observer2, team: team2)

        present_standup(team: team2, observer: observer2)
        expect(presented_new_faces(observer2)).not_to include(created_new_face(observer1))
        expect(presented_new_faces(observer2)).to include(created_new_face(observer2))
      end
    end

    def presented_new_faces(observer)
      observer.spy_presented_standup.new_faces
    end

    def created_new_face(observer)
      observer.spy_created_new_face
    end

    let(:team1) { observer1.spy_created_team }
    let(:team2) { observer2.spy_created_team }
    let(:observer1) { GuiSpy.new }
    let(:observer2) { GuiSpy.new }
    let(:new_face_repo) { FakeNewFaceRepo.new }
    let(:team_repo) { FakeTeamRepo.new }

    def create_new_face(observer:, team:)
      Board.create_new_face(
        observer: observer,
        attributes: valid_new_face_attributes,
        new_face_repo: new_face_repo,
        team_id: team.id,
      ).execute
    end

    def create_team(observer:)
      Board.create_team(
        observer: observer,
        attributes: valid_team_attributes,
        team_repo: team_repo,
      ).execute
    end

    def present_standup(team:, observer:)
      Board.present_standup(
        team_id: team.id,
        new_face_repo: new_face_repo,
        observer: observer,
      ).execute
    end
  end
end
