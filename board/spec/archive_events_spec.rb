require "board"
require "support/board_dsl"

describe "USE CASE: Present Events at Standup" do
  include BoardDSL

  context "Given there are past, now, and future events for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_event = create_event(whiteboard_id: @my_whiteboard.id, date: @past)
      @now_event = create_event(whiteboard_id: @my_whiteboard.id, date: @now)
      @future_event = create_event(whiteboard_id: @my_whiteboard.id, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' events on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@now_whiteboard.events).not_to include(@past_event, @now_event)
        expect(@now_whiteboard.events).to include(@future_event)
      end

      specify "And I should not see the past or 'now' events on the standup" do
        now_standup_events = present_standup(whiteboard_id: @my_whiteboard.id, date: @now).events

        expect(now_standup_events).not_to include(@past_event, @now_event)
        expect(now_standup_events).to include(@future_event)
      end

      specify "But I should still see future events on the 'now' standup" do
        now_standup_events = present_standup(whiteboard_id: @my_whiteboard.id, date: @now).events

        expect(now_standup_events).to include(@future_event)
      end

      specify "And I should still see future events on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.events).to include(@future_event)
      end
    end
  end
end
