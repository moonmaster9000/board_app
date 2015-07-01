require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"
require "support/board_test_dsl"

describe "USE CASE: Present New Faces at Standup and on Whiteboard" do
  include BoardTestDSL

  context "Given there are past, current, and future new faces for my whiteboard and another whiteboard" do
    before do
      @my_whiteboard = create_whiteboard
      @another_whiteboard = create_whiteboard
      @current = Date.today
      @future = @current.next_day
      @past_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @current.prev_day)
      @current_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @current)
      @future_new_face = create_new_face(whiteboard_id: @my_whiteboard.id, date: @future)
      @other_whiteboards_new_face = create_new_face(whiteboard_id: @another_whiteboard.id, date: @current)
    end

    context "When I present the current standup" do
      before do
        @current_standup = present_standup(whiteboard_id: @my_whiteboard.id, date: @current)
      end

      specify "Then I should see the past and current unarchived new faces" do
        expect(@current_standup.new_faces).to include(@current_new_face, @past_new_face)
      end

      specify "But I should not see future new faces" do
        new_faces = @current_standup.new_faces

        expect(new_faces).not_to include(@future_new_face)
      end

      specify "And I should not see other whiteboard's new faces" do
        new_faces = @current_standup.new_faces

        expect(new_faces).not_to include(@other_whiteboards_new_face)
      end
    end

    context "When I present the whiteboard" do
      before do
        @current_whiteboard = present_whiteboard(whiteboard_id: @my_whiteboard.id)
      end

      specify "Then I should see my whiteboard's past, current, and future new faces" do
        expect(@current_whiteboard.new_faces).to include(@current_new_face, @past_new_face, @future_new_face)
      end
      
      specify "But I should not see new faces for other whiteboards" do
        expect(@current_whiteboard.new_faces).not_to include(@other_whiteboards_new_face)
      end
    end
  end
end
