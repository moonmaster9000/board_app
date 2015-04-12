require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/test_attributes"

describe "USE CASE: Present a list of Teams" do
  include TestAttributes

  context "Given a valid team" do
    before do
      create_team
    end

    context "When I execute the present_team use case with that team's id" do
      before do
        present_teams
      end

      specify "Then it sends a presentable team to the gui" do
        expect(presented_teams).to include(created_team)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }
  let(:created_team) { gui.spy_created_team }
  let(:presented_teams) { gui.spy_presented_teams }

  def create_team
    Board.create_team(
        attributes: valid_team_attributes,
        observer: gui,
        team_repo: team_repo
    ).execute
  end

  def present_teams
    Board.present_teams(
        observer: gui,
        team_repo: team_repo
    ).execute
  end
end
