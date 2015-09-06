require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: reading an help" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an help already exists" do
    before do
      @whiteboard = create_whiteboard
      @help = create_help(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I pass the id of the help to the 'read_help' use case" do
      before do
        read_help(help_id: @help.id, observer: gui)
      end

      specify "Then the observer should receive the help" do
        expect(gui.spy_read_help).to eq(@help)
      end
    end

    context "When I pass an unknown id to the 'read_help' use case" do
      before do
        read_help(help_id: "unknown", observer: gui)
      end

      specify "Then the observer should be notified that the entity was not found" do
        expect(gui.spy_help_not_found).to be(true)
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
