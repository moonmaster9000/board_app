require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/test_attributes"

describe "creating a team" do
  include TestAttributes

  context "given an empty team name" do
    let(:attributes) do
      {name: ""}
    end

    it "should tell the observer that name is required" do
      Board.create_team(attributes: attributes, observer: gui, team_repo: team_repo).execute

      expect(gui.spy_validation_errors).to include(
        Board::ValidationError.new(
          field_name: :name,
          error: :required,
        )
      )
    end
  end

  context "given a valid team name" do
    let(:attributes) { valid_team_attributes }

    before do
      Board.create_team(attributes: attributes, observer: gui, team_repo: team_repo).execute
    end

    it "should create a team with the requested attributes" do
      expect(gui.spy_created_team.name).to eq(attributes[:name])
    end

    it "should save the team so that we can use it later" do
      Board.present_team(observer: gui, team_id: gui.spy_created_team.id, team_repo: team_repo).execute
      expect(gui.spy_presented_team).to eq(gui.spy_created_team)
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }
end
