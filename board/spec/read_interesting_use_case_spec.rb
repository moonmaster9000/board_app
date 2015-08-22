require "board"
require "board_test_support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: reading an interesting" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an interesting already exists" do
    before do
      @whiteboard = create_whiteboard
      @interesting = create_interesting(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I pass the id of the interesting to the 'read_interesting' use case" do
      before do
        read_interesting(interesting_id: @interesting.id, observer: gui)
      end

      specify "Then the observer should receive the interesting" do
        expect(gui.spy_read_interesting).to eq(@interesting)
      end
    end

    context "When I pass an unknown id to the 'read_interesting' use case" do
      before do
        read_interesting(interesting_id: "unknown", observer: gui)
      end

      specify "Then the observer should be notified that the entity was not found" do
        expect(gui.spy_interesting_not_found).to be(true)
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
