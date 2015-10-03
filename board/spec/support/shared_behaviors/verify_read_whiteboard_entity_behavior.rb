require "board"
require "support/doubles/gui_spy"
require "support/board_test_dsl"
require "support/common_assertions"


def verify_read_whiteboard_entity_behavior(entity_name:)
  describe "USE CASE: reading an #{entity_name}" do
    include CommonAssertions
    include BoardTestDSL

    context "Given an #{entity_name} already exists" do
      before do
        @whiteboard = create_whiteboard
        @entity = create_entity(entity_name: entity_name, whiteboard_id: @whiteboard.id, observer: gui)
      end

      context "When I pass the id of the #{entity_name} to the 'read_#{entity_name}' use case" do
        before do
          read_entity(entity_name: entity_name, entity_id: @entity.id, observer: gui)
        end

        specify "Then the observer should receive the #{entity_name}" do
          expect(gui.send("spy_read_#{entity_name}")).to eq(@entity)
        end
      end

      context "When I pass an unknown id to the 'read_#{entity_name}' use case" do
        before do
          read_entity(entity_name: entity_name, entity_id: "unknown", observer: gui)
        end

        specify "Then the observer should be notified that the entity was not found" do
          expect(gui.send("spy_#{entity_name}_not_found")).to be(true)
        end
      end
    end

    let(:gui) { GuiSpy.new }

    def read_entity(entity_name:, entity_id:, observer:)
      send "read_#{entity_name}", :"#{entity_name}_id" => entity_id, observer: observer
    end

    def create_entity(entity_name:, **attrs)
      send "create_#{entity_name}", attrs
    end
  end
end
