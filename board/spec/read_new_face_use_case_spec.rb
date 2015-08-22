require "board"
require "board_test_support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: reading an new_face" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an new_face already exists" do
    before do
      @whiteboard = create_whiteboard
      @new_face = create_new_face(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I pass the id of the new_face to the 'read_new_face' use case" do
      before do
        read_new_face(new_face_id: @new_face.id, observer: gui)
      end

      specify "Then the observer should receive the new_face" do
        expect(gui.spy_read_new_face).to eq(@new_face)
      end
    end

    context "When I pass an unknown id to the 'read_new_face' use case" do
      before do
        read_new_face(new_face_id: "unknown", observer: gui)
      end

      specify "Then the observer should be notified that the entity was not found" do
        expect(gui.spy_new_face_not_found).to be(true)
      end
    end
  end

  let(:gui) { GuiSpy.new }
end
