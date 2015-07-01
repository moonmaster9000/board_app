require "board"
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
    end

    context "When I archive the current standup" do
      before do
        archive_standup(@my_whiteboard.id, @current)
      end

      specify "Then I should not see the past or current events on the whiteboard" do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@current_whiteboard.events).not_to include(@past_event, @current_event)
        expect(@current_whiteboard.events).to include(@future_event)
      end

      specify "And I should not see the past or current events on the standup" do
        current_standup_events = present_standup(whiteboard_id: @my_whiteboard.id, date: @current).events

        expect(current_standup_events).not_to include(@past_event, @current_event)
        expect(current_standup_events).to include(@future_event)
      end

      specify "But I should still see future events on the current standup" do
        current_standup_events = present_standup(whiteboard_id: @my_whiteboard.id, date: @current).events

        expect(current_standup_events).to include(@future_event)
      end

      specify "And I should still see future events on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.events).to include(@future_event)
      end
    end
  end
end
