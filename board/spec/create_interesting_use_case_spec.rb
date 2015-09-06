require "board"
require "support/doubles/gui_spy"
require "support/common_assertions"
require "support/board_test_dsl"


describe "USE CASE: creating a interesting" do
  include CommonAssertions
  include BoardTestDSL

  context "Given a whiteboard exists" do
    before do
      @whiteboard_id = create_whiteboard.id
    end

    context "when the attributes are invalid" do
      context "because the date is blank" do
        it "informs the observer that a date is required" do
          create_interesting(whiteboard_id: @whiteboard_id, observer: gui, date: nil)
          assert_observer_got_one_error(gui, :date, :required)
        end
      end

      context "because the title is blank" do
        it "informs the observer that a description is required" do
          create_interesting(whiteboard_id: @whiteboard_id, observer: gui, title: nil)
          assert_observer_got_one_error(gui, :title, :required)
        end
      end

      context "because I don't give it a whiteboard_id" do
        it "informs the observer that a whiteboard_id is required" do
          create_interesting(whiteboard_id: nil, observer: gui)
          assert_observer_got_one_error(gui, :whiteboard_id, :required)
        end
      end
    end

    context "when the attributes are valid" do
      let(:attributes) { valid_interesting_attributes }

      it "sends a interesting back to the gui with the requested attributes" do
        create_interesting({whiteboard_id: @whiteboard_id, observer: gui}.merge(attributes))
        expect(gui.spy_created_interesting.attributes).to include(attributes)
      end

      it "doesn't send any validation errors" do
        create_interesting({whiteboard_id: @whiteboard_id, observer: gui}.merge(attributes))
        expect(gui.spy_validation_errors).not_to be
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
