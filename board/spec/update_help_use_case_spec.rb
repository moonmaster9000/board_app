require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


describe "USE CASE: updateing an help" do
  include CommonAssertions
  include BoardTestDSL

  context "Given an help already exists" do
    before do
      @whiteboard = create_whiteboard
      @help = create_help(whiteboard_id: @whiteboard.id, observer: gui)
    end

    context "When I update it" do
      context "And I provide invalid attributes" do
        before do
          update_help(help_id: @help.id, observer: gui, **invalid_help_attributes)
        end

        it "sends validation errors to the observer" do
          expect(gui.spy_validation_errors).to be
        end
      end

      context "And I provide a valid date, description, and whiteboard_id" do
        before do
          @new_date = valid_help_attributes[:date].next_day
          @new_description = rand.to_s

          update_help(help_id: @help.id, observer: gui, date: @new_date, description: @new_description)
        end

        it "sends a help back to the gui with the requested attributes" do
          expect(gui.spy_updated_help.attributes).to include({date: @new_date, description: @new_description})
        end

        it "doesn't send any validation errors" do
          expect(gui.spy_validation_errors).not_to be
        end
      end
    end
  end

  context "When I try to update an help that doesn't exist" do
    before do
      update_help(help_id: "bogus_id", observer: gui)
    end

    specify "Then the use case should notify the observer that the help is not found" do
      expect(gui.spy_entity_not_found).to be(true)
    end
  end

  let(:gui) { GuiSpy.new }
end
