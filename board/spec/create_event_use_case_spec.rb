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
      context "because the date is blank" do
        it "informs the observer that a date is required" do
          create_event(whiteboard_id: @whiteboard.id, observer: gui, date: nil)
          assert_observer_got_one_error(gui, :date, :required)
        end
      end

      context "because the title is blank" do
        it "informs the observer that a description is required" do
          create_event(whiteboard_id: @whiteboard.id, observer: gui, title: nil)
          assert_observer_got_one_error(gui, :title, :required)
        end
      end

      context "because I don't give it a whiteboard_id" do
        it "informs the observer that a whiteboard_id is required" do
          create_event(whiteboard_id: nil, observer: gui)
          assert_observer_got_one_error(gui, :whiteboard_id, :required)
        end
      end
    end

    context "when the attributes are valid" do
      let(:event_attributes) { valid_event_attributes }

      before do
        create_event({whiteboard_id: @whiteboard.id, observer: gui}.merge(event_attributes))
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
