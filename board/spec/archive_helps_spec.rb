require "board"
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
    end

    context "When I archive the current standup" do
      before do
        archive_standup(@my_whiteboard.id, @current)
      end

      specify "Then I should not see the past or current helps on the whiteboard" do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@current_whiteboard.helps).not_to include(@past_help, @current_help)
        expect(@current_whiteboard.helps).to include(@future_help)
      end

      specify "Then I should not see any helps on the current standup" do
        current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)

        expect(current_standup.helps).to be_empty
      end

      specify "But I should still new future helps on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.helps).to include(@future_help)
      end
    end
  end
end
