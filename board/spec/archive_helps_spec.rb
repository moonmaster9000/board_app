require "board"
require "support/board_dsl"

describe "USE CASE: Present Helps at Standup" do
  include BoardDSL

  context "Given there are past, now, and future helps for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_help = create_help(whiteboard_id: @my_whiteboard.id, date: @past)
      @now_help = create_help(whiteboard_id: @my_whiteboard.id, date: @now)
      @future_help = create_help(whiteboard_id: @my_whiteboard.id, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' helps on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@now_whiteboard.helps).not_to include(@past_help, @now_help)
        expect(@now_whiteboard.helps).to include(@future_help)
      end

      specify "Then I should not see any helps on the current standup" do
        present_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @now)

        expect(present_standup.helps).to be_empty
      end

      specify "But I should still new future helps on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.helps).to include(@future_help)
      end
    end
  end
end
