require "board"
require "board_test_support/doubles/gui_spy"

describe "creating a team" do
  context "given an empty team name" do
    let(:name) { "" }

    it "should tell the observer that name is required" do
      Board.create_team(name: name, observer: gui).execute
      expect(gui.spy_validation_errors).to include("name is required")
    end
  end

  context "given a valid team name" do
    let(:name) { "Valid Team Name" }

    before do
      Board.create_team(name: name, observer: gui).execute
    end


    it "should create a team with the requested attributes" do
      expect(gui.spy_created_team.name).to eq(name)
    end

    it "should save the team so that we can use it later" do
      # ... Prepare for repo spec
    end
  end

  let(:gui) { GuiSpy.new }
end
