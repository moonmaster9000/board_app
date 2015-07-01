require "board"
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
    end

    context "When I archive the current standup" do
      before do
        archive_standup(@my_whiteboard.id, @current)
      end

      specify "Then I should not see the past or current interestings on the whiteboard" do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@current_whiteboard.interestings).not_to include(@past_interesting, @current_interesting)
        expect(@current_whiteboard.interestings).to include(@future_interesting)
      end

      specify "Then I should not see any interestings on the current standup" do
        current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)

        expect(current_standup.interestings).to be_empty
      end

      specify "But I should still new future interestings on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.interestings).to include(@future_interesting)
      end
    end
  end
end
