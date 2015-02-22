require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/test_attributes"

describe "USE CASE: Present Team" do
  include TestAttributes

  context "Given a valid team" do
    before do
      create_team
    end

    context "When I execute the present_team use case with that team's id" do
      before do
        present_team(created_team.id)
      end

      specify "Then it sends a presentable team to the gui" do
        expect(team_presented_to_gui).to eq(created_team)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }
  let(:created_team) { gui.spy_created_team }
  let(:team_presented_to_gui) { gui.spy_presented_team }

  def create_team
    Board.create_team(
      attributes: valid_team_attributes,
      observer: gui,
      team_repo: team_repo
    ).execute
  end

  def present_team(created_team_id)
    Board.present_team(
      observer: gui,
      team_id: created_team_id,
      team_repo: team_repo
    ).execute
  end
end
