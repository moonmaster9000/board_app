require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: updateing an interesting" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an interesting already exists" do
    before do
      @whiteboard = create_whiteboard
      @interesting = create_interesting(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I update it" do
      context "And I provide invalid attributes" do
        before do
          update_interesting(interesting_id: @interesting.id, observer: gui, **invalid_interesting_attributes)
        end

        it "sends validation errors to the observer" do
          expect(gui.spy_validation_errors).to be
        end
      end

      context "And I provide a valid date, title, and whiteboard_id" do
        before do
          @new_date = valid_interesting_attributes[:date].next_day
          @new_title = rand.to_s

          update_interesting(interesting_id: @interesting.id, observer: gui, date: @new_date, title: @new_title)
        end

        it "sends a interesting back to the gui with the requested attributes" do
          expect(gui.spy_updated_interesting.attributes).to include({date: @new_date, title: @new_title})
        end

        it "doesn't send any validation errors" do
          expect(gui.spy_validation_errors).not_to be
        end
      end
    end
  end

  context "When I try to update an interesting that doesn't exist" do
    before do
      update_interesting(interesting_id: "bogus_id", observer: gui)
    end

    specify "Then the use case should notify the observer that the interesting is not found" do
      expect(gui.spy_entity_not_found).to be(true)
    end
  end

  let(:gui) { GuiSpy.new }
end
