require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: reading an event" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an event already exists" do
    before do
      @whiteboard = create_whiteboard
      @event = create_event(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I pass the id of the event to the 'read_event' use case" do
      before do
        read_event(event_id: @event.id, observer: gui)
      end

      specify "Then the observer should receive the event" do
        expect(gui.spy_read_event).to eq(@event)
      end
    end

    context "When I pass an unknown id to the 'read_event' use case" do
      before do
        read_event(event_id: "unknown", observer: gui)
      end

      specify "Then the observer should be notified that the entity was not found" do
        expect(gui.spy_event_not_found).to be(true)
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
