require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_team_repo"
require "board_test_support/test_attributes"
require "support/common_assertions"

describe "USE CASE: Create Team" do
  include TestAttributes
  include CommonAssertions

  context "Given an empty team name" do
    let(:attributes) do
      valid_team_attributes.merge(name: "")
    end

    context "When I use the create_team use case with that empty team name" do
      before do
        create_team
      end

      specify "Then it should tell the observer that name is required" do
        assert_gui_received_error(:name, :required)
      end
    end
  end

  context "Given a valid team name" do
    let(:attributes) { valid_team_attributes }

    context "When I use the create_team use case with that valid team name" do
      before do
        create_team
      end

      specify "Then it should create a team with the requested attributes" do
        expect(gui.spy_created_team.name).to eq(attributes[:name])
      end

      specify "Then it should save the team so that we can use it later" do
        present_team
        expect(gui.spy_presented_team).to eq(gui.spy_created_team)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:team_repo) { FakeTeamRepo.new }

  def create_team
    Board.create_team(
      attributes: attributes,
      observer: gui,
      team_repo: team_repo
    ).execute
  end

  def present_team
    Board.present_team(
      observer: gui,
      team_id: gui.spy_created_team.id,
      team_repo: team_repo
    ).execute
  end
end
