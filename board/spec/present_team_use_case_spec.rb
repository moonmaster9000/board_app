require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/test_attributes"

describe "presenting a team" do
  include TestAttributes

  context "when the team exists" do
    it "presents the team to the gui" do
      Board.create_team(attributes: valid_team_attributes, observer: gui, team_repo: team_repo).execute
      Board.present_team(observer: gui, team_id: gui.spy_created_team.id, team_repo: team_repo).execute

      expect(gui.spy_presented_team).to eq(gui.spy_created_team)
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }
end
