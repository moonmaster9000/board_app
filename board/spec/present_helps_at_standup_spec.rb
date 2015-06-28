require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_dsl"

describe "USE CASE: Present Helps at Standup" do
  include BoardDSL

  context "Given there are past, now, and future helps for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_help = create_help(whiteboard: @my_whiteboard, date: @past)
      @now_help = create_help(whiteboard: @my_whiteboard, date: @now)
      @future_help = create_help(whiteboard: @my_whiteboard, date: @future)

      @different_whiteboard = create_whiteboard
      @help_for_different_whiteboard = create_help(whiteboard: @different_whiteboard, date: @now)
    end

    context "When I present the standup for the 'now'" do
      before do
        @now_standup = present_standup(whiteboard: @my_whiteboard, date: @now)
      end

      specify "Then I should see the past and 'now' helps" do
        expect(@now_standup.helps).to include(@past_help, @now_help)
      end

      specify "But I should not see future helps" do
        expect(@now_standup.helps).not_to include(@future_help)
      end
      
      specify "And I should not see other whiteboard helps" do
        expect(@now_standup.helps).not_to include @help_for_different_whiteboard
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)
      end

      specify "Then I should see my whiteboard's past, 'now', and future helps" do
        expect(@now_whiteboard.helps).to include(@now_help, @past_help, @future_help)
      end

      specify "But I should not see helps for other whiteboards" do
        expect(@now_whiteboard.helps).not_to include(@help_for_different_whiteboard)
      end
    end
  end
end
