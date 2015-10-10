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
      before do
        create_interesting(whiteboard_id: @whiteboard_id, observer: gui, **invalid_interesting_attributes)
      end

      it "sends the validation errors to the observer" do
        expect(gui.spy_validation_errors).not_to be_empty
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
