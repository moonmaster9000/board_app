require "board"
require "support/board_dsl"

describe "USE CASE: Present Interestings at Standup" do
  include BoardDSL

  context "Given there are past, now, and future interestings for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @past)
      @now_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @now)
      @future_interesting = create_interesting(whiteboard_id: @my_whiteboard.id, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' interestings on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@now_whiteboard.interestings).not_to include(@past_interesting, @now_interesting)
        expect(@now_whiteboard.interestings).to include(@future_interesting)
      end

      specify "Then I should not see any interestings on the current standup" do
        present_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @now)

        expect(present_standup.interestings).to be_empty
      end

      specify "But I should still new future interestings on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.interestings).to include(@future_interesting)
      end
    end
  end
end
