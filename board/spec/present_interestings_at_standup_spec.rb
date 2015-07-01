require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_dsl"

describe "USE CASE: Present Interestings at Standup" do
  include BoardDSL

  context "Given there are past, current, and future interestings for my whiteboard" do
    before do
      @current = Date.today
      @past = @current.prev_day
      @future = @current.next_day
      
      @my_whiteboard = create_whiteboard
      @past_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @past)
      @current_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @current)
      @future_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @future)

      @different_whiteboard = create_whiteboard
      @interesting_for_different_whiteboard = create_interesting(whiteboard_id: @different_whiteboard.id, date: @current)
    end

    context "When I present the standup for the current" do
      before do
        @current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)
      end

      specify "Then I should see the past and current interestings" do
        expect(@current_standup.interestings).to include(@past_interesting, @current_interesting)
      end

      specify "But I should not see future interestings" do
        expect(@current_standup.interestings).not_to include(@future_interesting)
      end
      
      specify "And I should not see other whiteboard interestings" do
        expect(@current_standup.interestings).not_to include @interesting_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)
      end

      specify "Then I should see my whiteboard's past, current, and future interestings" do
        expect(@current_whiteboard.interestings).to include(@current_interesting, @past_interesting, @future_interesting)
      end

      specify "But I should not see interestings for other whiteboards" do
        expect(@current_whiteboard.interestings).not_to include(@interesting_for_different_whiteboard)
      end
    end
  end
end
