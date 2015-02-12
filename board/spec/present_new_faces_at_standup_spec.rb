require 'board'
require 'board_test_support/test_attributes'
require 'board_test_support/doubles/gui_spy'
require 'board_test_support/doubles/fake_new_face_repo'
require 'board_test_support/doubles/fake_team_repo'

describe "presenting new faces at a standup" do
  include TestAttributes

  context "Given there are new faces for a team" do
    before do
      create_team
      create_new_face
    end

    context "When I present the standup for that team" do
      before do
        present_standup
      end

      specify "Then I should see those new faces" do
        expect(presented_new_faces).to include(created_new_face)
      end
    end

    let(:presented_new_faces) { gui.spy_presented_standup.new_faces }
    let(:created_new_face) { gui.spy_created_new_face }
    let(:gui) { GuiSpy.new }
    let(:new_face_repo) { FakeNewFaceRepo.new }
    let(:team_repo) { FakeTeamRepo.new }

    def create_new_face
      Board.create_new_face(
        observer: gui,
        attributes: valid_new_face_attributes,
        new_face_repo: new_face_repo,
        team_id: gui.spy_created_team.id,
      ).execute
    end

    def create_team
      Board.create_team(
        observer: gui,
        attributes: valid_team_attributes,
        team_repo: team_repo,
      ).execute
    end

    def present_standup
      Board.present_standup(
        team_id: gui.spy_created_team.id,
        new_face_repo: new_face_repo,
        observer: gui,
      ).execute
    end
  end
end
