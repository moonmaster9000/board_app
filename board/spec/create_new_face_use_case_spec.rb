require 'date'
require 'board'
require 'board_test_support/doubles/gui_spy'
require 'board_test_support/test_attributes'
require 'board_test_support/doubles/fake_team_repo'
require 'board_test_support/doubles/fake_new_face_repo'

describe "creating a new face" do
  include TestAttributes

  context "when the team id is valid" do
    it "persists the new face"

    it "gives the new face back to the observer" do
      Board.create_team(attributes: valid_team_attributes, observer: gui, team_repo: team_repo).execute

      new_face_attributes = {name: 'Valid New Face Name', date: Date.new(2011,4,4) }

      Board.create_new_face(observer: gui,
        team_id: gui.spy_created_team.id,
        new_face_repo: new_face_repo,
        attributes: new_face_attributes).execute

      expect(gui.spy_created_new_face.attributes).to include(new_face_attributes)
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }
  let(:new_face_repo) { FakeNewFaceRepo.new }
end
