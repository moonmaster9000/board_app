require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_test_dsl"

describe "USE CASE: Present Events at Standup" do
  include BoardTestDSL

  context "Given there are past, current, and future events for my whiteboard" do
    before do
      @current = Date.today
      @past = @current.prev_day
      @future = @current.next_day
      
      @my_whiteboard = create_whiteboard
      @past_event = create_event(whiteboard_id: @my_whiteboard.id, date: @past)
      @current_event = create_event(whiteboard_id: @my_whiteboard.id, date: @current)
      @future_event = create_event(whiteboard_id: @my_whiteboard.id, date: @future)

      @different_whiteboard = create_whiteboard
      @event_for_different_whiteboard = create_event(whiteboard_id: @different_whiteboard.id, date: @current)
    end

    context "When I present the standup for the current" do
      before do
        @current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)
      end

      specify "Then I should see my whiteboard's past, current, and future events" do
        expect(@current_standup.events).to include(@past_event, @current_event, @future_event)
      end

      specify "But I should not see other whiteboard events" do
        expect(@current_standup.events).not_to include @event_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)
      end

      specify "Then I should see my whiteboard's past, current, and future events" do
        expect(@current_whiteboard.events).to include(@current_event, @past_event, @future_event)
      end

      specify "But I should not see events for other whiteboards" do
        expect(@current_whiteboard.events).not_to include(@event_for_different_whiteboard)
      end
    end
  end
end

