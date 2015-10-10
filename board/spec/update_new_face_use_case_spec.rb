require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: updateing an new_face" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an new_face already exists" do
    before do
      @whiteboard = create_whiteboard
      @new_face = create_new_face(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I update it" do
      context "And I provide invalid attributes" do
        before do
          update_new_face(new_face_id: @new_face.id, observer: gui, **invalid_new_face_attributes)
        end

        it "sends validation errors to the observer" do
          expect(gui.spy_validation_errors).to be
        end
      end

      context "And I provide a valid date, name, and whiteboard_id" do
        before do
          @new_date = valid_new_face_attributes[:date].next_day
          @new_name = rand.to_s

          update_new_face(new_face_id: @new_face.id, observer: gui, date: @new_date, name: @new_name)
        end

        it "sends a new_face back to the gui with the requested attributes" do
          expect(gui.spy_updated_new_face.attributes).to include({date: @new_date, name: @new_name})
        end

        it "doesn't send any validation errors" do
          expect(gui.spy_validation_errors).not_to be
        end
      end
    end
  end

  context "When I try to update an new_face that doesn't exist" do
    before do
      update_new_face(new_face_id: "bogus_id", observer: gui)
    end

    specify "Then the use case should notify the observer that the new_face is not found" do
      expect(gui.spy_entity_not_found).to be(true)
    end
  end

  let(:gui) { GuiSpy.new }
end
