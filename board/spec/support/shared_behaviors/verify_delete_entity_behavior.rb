require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"

def verify_delete_entity_behavior(entity_name:)
  describe "Delete Entity Use Case Behavior" do
    include CommonAssertions
    include BoardTestDSL

    context "Given an event already exists" do
      before do
        @whiteboard = create_whiteboard
        @entity = create_entity(entity_name: entity_name, whiteboard_id: @whiteboard.id, observer: gui)
      end

      context "When I pass the id of that event to the delete_event use case" do
        before do
          delete_entity(entity_name: entity_name, entity_id: @entity.id, observer: gui)
        end

        specify "Then it tells the observer that the delete succeeded" do
          expect(gui.spy_delete_succeeded).to be(true)
        end

        specify "And it is no longer possible to use that event id for anything" do
          read_event(event_id: @entity.id, observer: gui)
          expect(gui.spy_event_not_found).to be(true)
        end
      end
    end

    context "When I try to delete an event that doesn't exist" do
      before do
        delete_entity(entity_name: entity_name, entity_id: "bogus_id", observer: gui)
      end

      specify "Then the use case should notify the observer that the event is not found" do
        expect(gui.spy_entity_not_found).to be(true)
      end
    end

    let(:gui) { GuiSpy.new }

    def create_entity(entity_name:, whiteboard_id:, observer:)
      send "create_#{entity_name}", whiteboard_id: whiteboard_id, observer: observer
    end

    def delete_entity(entity_name:, entity_id:, observer:)
      send "delete_#{entity_name}", :"#{entity_name}_id" => entity_id, observer: observer
    end
  end
end
