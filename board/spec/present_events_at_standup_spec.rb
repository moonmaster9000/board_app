require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_dsl"

describe "USE CASE: Present Events at Standup" do
  include BoardDSL

  context "Given there are past, now, and future events for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_event = create_event(whiteboard: @my_whiteboard, date: @past)
      @now_event = create_event(whiteboard: @my_whiteboard, date: @now)
      @future_event = create_event(whiteboard: @my_whiteboard, date: @future)

      @different_whiteboard = create_whiteboard
      @event_for_different_whiteboard = create_event(whiteboard: @different_whiteboard, date: @now)
    end

    context "When I present the standup for the 'now'" do
      before do
        @now_standup = present_standup(whiteboard: @my_whiteboard, date: @now)
      end

      specify "Then I should see my whiteboard's past, 'now', and future events" do
        expect(@now_standup.events).to include(@past_event, @now_event, @future_event)
      end

      specify "But I should not see other whiteboard events" do
        expect(@now_standup.events).not_to include @event_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)
      end

      specify "Then I should see my whiteboard's past, 'now', and future events" do
        expect(@now_whiteboard.events).to include(@now_event, @past_event, @future_event)
      end

      specify "But I should not see events for other whiteboards" do
        expect(@now_whiteboard.events).not_to include(@event_for_different_whiteboard)
      end
    end
  end
end

