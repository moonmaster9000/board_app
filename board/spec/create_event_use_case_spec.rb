require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"

describe "USE CASE: creating a event" do
  include CommonAssertions
  include BoardTestDSL

  context "Given a whiteboard exists" do
    before do
      @whiteboard = create_whiteboard
    end

    context "when the attributes are invalid" do
      before do
        create_event(whiteboard_id: @whiteboard.id, observer: gui, **invalid_event_attributes)
      end

      it "sends the validation errors to the observer" do
        expect(gui.spy_validation_errors).not_to be_empty
      end
    end

    context "when the attributes are valid" do
      let(:event_attributes) { valid_event_attributes }

      before do
        create_event(whiteboard_id: @whiteboard.id, observer: gui, **event_attributes)
      end

      it "sends a event back to the gui with the requested attributes" do
        expect(gui.spy_created_event.attributes).to include(event_attributes)
      end

      it "doesn't send any validation errors" do
        expect(gui.spy_validation_errors).not_to be
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
