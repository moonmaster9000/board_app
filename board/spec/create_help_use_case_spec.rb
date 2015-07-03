require "board"
require "board_test_support/doubles/gui_spy"
require "support/common_assertions"
require "support/board_test_dsl"


describe "USE CASE: creating a help" do
  include CommonAssertions
  include BoardTestDSL

  context "Given a whiteboard exists" do
    before do
      @whiteboard_id = create_whiteboard.id
    end

    context "when the attributes are invalid" do
      context "because the date is blank" do
        it "informs the observer that a date is required" do
          create_help(whiteboard_id: @whiteboard_id, observer: gui, date: nil)
          assert_observer_got_one_error(gui, :date, :required)
        end
      end

      context "because the description is blank" do
        it "informs the observer that a description is required" do
          create_help(whiteboard_id: @whiteboard_id, observer: gui, description: nil)
          assert_observer_got_one_error(gui, :description, :required)
        end
      end

      context "because I don't give it a whiteboard_id" do
        it "informs the observer that a whiteboard_id is required" do
          create_help(whiteboard_id: nil, observer: gui)
          assert_observer_got_one_error(gui, :whiteboard_id, :required)
        end
      end
    end

    context "when the attributes are valid" do
      let(:attributes) { valid_help_attributes }

      before do
        create_help({whiteboard_id: @whiteboard_id, observer: gui}.merge(attributes))
      end

      it "sends a help back to the gui with the requested attributes" do
        expect(gui.spy_created_help.attributes).to include(attributes)
      end

      it "doesn't send any validation errors" do
        expect(gui.spy_validation_errors).not_to be
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
