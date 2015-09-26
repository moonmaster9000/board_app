require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: delete an event" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an event already exists" do
    before do
      @whiteboard = create_whiteboard
      @event = create_event(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I pass the id of that event to the delete_event use case" do
      before do
        delete_event(event_id: @event.id, observer: gui)
      end

      specify "Then it tells the observer that the delete succeeded" do
        expect(gui.spy_delete_succeeded).to be(true)
      end

      specify "And it is no longer possible to use that event id for anything" do
        read_event(event_id: @event.id, observer: gui)
        expect(gui.spy_event_not_found).to be(true)
      end
    end
  end

  context "When I try to delete an event that doesn't exist" do
    before do
      delete_event(event_id: "bogus_id", observer: gui)
    end

    specify "Then the use case should notify the observer that the event is not found" do
      expect(gui.spy_entity_not_found).to be(true)
    end
  end

  let(:gui) { GuiSpy.new }
end
