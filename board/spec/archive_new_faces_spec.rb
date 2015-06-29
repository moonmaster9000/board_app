require "board"
require "support/board_dsl"

describe "USE CASE: Archive New Faces at Standup and on Whiteboard" do
  include BoardDSL

  context "Given there are past, now, and future new faces for my whiteboard" do
    before do
      @my_whiteboard = create_whiteboard
      @now = Date.today
      @future = @now.next_day

      @past_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @now.prev_day)
      @now_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @now)
      @future_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then the observer should be notified that the standup was archived" do
        expect(observer.spy_standup_archived).to be(true)
      end

      specify "Then I should not see the past or 'now' new faces on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)

        expect(@now_whiteboard.new_faces).not_to include(@past_new_face, @now_new_face)
        expect(@now_whiteboard.new_faces).to include(@future_new_face)
      end

      specify "Then I should not see any new faces on the current standup" do
        now_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @now)

        expect(now_standup.new_faces).to be_empty
      end

      specify "But I should still new future new faces on the future standup" do
        future_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @future)

        expect(future_standup.new_faces).to include(@future_new_face)
      end
    end
  end
end
