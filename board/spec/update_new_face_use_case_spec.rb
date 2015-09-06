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
      context "And I try to blank out the date" do
        before do
          update_new_face(new_face_id: @new_face.id, observer: gui, date: nil)
        end
        
        it "informs the observer that a date is required" do
          assert_observer_got_one_error(gui, :date, :required)
        end
      end

      context "And I try to blank out the name" do
        before do
          update_new_face(new_face_id: @new_face.id, observer: gui, name: nil)
        end

        it "informs the observer that a name is required" do
          assert_observer_got_one_error(gui, :name, :required)
        end
      end

      context "And I try to blank out the whiteboard_id" do
        before do
          update_new_face(new_face_id: @new_face.id, observer: gui, whiteboard_id: nil)
        end

        it "informs the observer that a whiteboard_id is required" do
          assert_observer_got_one_error(gui, :whiteboard_id, :required)
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
