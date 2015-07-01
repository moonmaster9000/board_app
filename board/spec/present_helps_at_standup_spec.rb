require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_test_dsl"

describe "USE CASE: Present Helps at Standup" do
  include BoardTestDSL

  context "Given there are past, current, and future helps for my whiteboard" do
    before do
      @current = Date.today
      @past = @current.prev_day
      @future = @current.next_day
      
      @my_whiteboard = create_whiteboard
      @past_help = create_help(whiteboard_id: @my_whiteboard.id, date: @past)
      @current_help = create_help(whiteboard_id: @my_whiteboard.id, date: @current)
      @future_help = create_help(whiteboard_id: @my_whiteboard.id, date: @future)

      @different_whiteboard = create_whiteboard
      @help_for_different_whiteboard = create_help(whiteboard_id: @different_whiteboard.id, date: @current)
    end

    context "When I present the standup for the current" do
      before do
        @current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)
      end

      specify "Then I should see the past and current helps" do
        expect(@current_standup.helps).to include(@past_help, @current_help)
      end

      specify "But I should not see future helps" do
        expect(@current_standup.helps).not_to include(@future_help)
      end
      
      specify "And I should not see other whiteboard helps" do
        expect(@current_standup.helps).not_to include @help_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)
      end

      specify "Then I should see my whiteboard's past, current, and future helps" do
        expect(@current_whiteboard.helps).to include(@current_help, @past_help, @future_help)
      end

      specify "But I should not see helps for other whiteboards" do
        expect(@current_whiteboard.helps).not_to include(@help_for_different_whiteboard)
      end
    end
  end
end
