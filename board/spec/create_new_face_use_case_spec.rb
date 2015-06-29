require "date"
require "board"
require "board_test_support/doubles/gui_spy"
require "support/common_assertions"
require "support/board_dsl"

describe "USE CASE: creating a new_face" do
  include CommonAssertions
  include BoardDSL

  context "Given a whiteboard exists" do
    before do
      @whiteboard_id = create_whiteboard.id
    end

    context "when the attributes are invalid" do
      context "because the date is blank" do
        it "informs the observer that a date is required" do
          create_new_face(whiteboard_id: @whiteboard_id, observer: gui, date: nil)
          assert_gui_got_one_error(gui, :date, :required)
        end
      end

      context "because the name is blank" do
        it "informs the observer that a name is required" do
          create_new_face(whiteboard_id: @whiteboard_id, observer: gui, name: nil)
          assert_gui_got_one_error(gui, :name, :required)
        end
      end
    end

    context "when the attributes are valid" do
      let(:attributes) { valid_new_face_attributes }

      before do
        create_new_face({whiteboard_id: @whiteboard_id, observer: gui}.merge(attributes))
      end

      it "sends a new_face back to the gui with the requested attributes" do
        expect(gui.spy_created_new_face.attributes).to include(attributes)
      end

      it "doesn't send any validation errors" do
        expect(gui.spy_validation_errors).not_to be
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
