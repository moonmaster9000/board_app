require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: updateing an event" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an event already exists" do
    before do
      @whiteboard = create_whiteboard
      @event = create_event(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I update it" do
      context "And I provide invalid attributes" do
        before do
          update_event(event_id: @event.id, observer: gui, **invalid_event_attributes)
        end
        
        it "sends validation errors to the observer" do
          expect(gui.spy_validation_errors).to be
        end
      end

      context "And I provide valid attributes" do
        before do
          new_date = valid_event_attributes[:date].next_day
          new_title = rand.to_s
          @updated_valid_attributes = valid_event_attributes.merge(date: new_date, title: new_title)

          update_event(event_id: @event.id, observer: gui, **@updated_valid_attributes)
        end

        it "sends a event back to the gui with the requested attributes" do
          expect(gui.spy_updated_event.attributes).to include(@updated_valid_attributes)
        end

        it "saves the event" do
          expect(read_event(event_id: @event.id).attributes).to include(@updated_valid_attributes)
        end

        it "doesn't send any validation errors" do
          expect(gui.spy_validation_errors).not_to be
        end
      end
    end
  end

  context "When I try to update an event that doesn't exist" do
    before do
      update_event(event_id: "bogus_id", observer: gui)
    end

    specify "Then the use case should notify the observer that the event is not found" do
      expect(gui.spy_entity_not_found).to be(true)
    end
  end

  let(:gui) { GuiSpy.new }
end
