require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present New Faces at Standup and on Whiteboard" do
  context "Given there are past, now, and future new faces for my whiteboard and another whiteboard" do
    before do
      @my_whiteboard = create_whiteboard
      @another_whiteboard = create_whiteboard
      @now = Date.today
      @future = @now.next_day
      @past_new_face = create_new_face(whiteboard: @my_whiteboard, date: @now.prev_day)
      @now_new_face = create_new_face(whiteboard: @my_whiteboard, date: @now)
      @future_new_face = create_new_face(whiteboard: @my_whiteboard, date: @future)
      @other_whiteboards_new_face = create_new_face(whiteboard: @another_whiteboard, date: @now)
    end

    context "When I present the 'now' standup" do
      before do
        @now_standup = present_standup(whiteboard: @my_whiteboard, date: @now)
      end

      specify "Then I should see the past and 'now' unarchived new faces" do
        expect(@now_standup.new_faces).to include(@now_new_face, @past_new_face)
      end

      specify "But I should not see future new faces" do
        new_faces = @now_standup.new_faces

        expect(new_faces).not_to include(@future_new_face)
      end

      specify "And I should not see other whiteboard's new faces" do
        new_faces = @now_standup.new_faces

        expect(new_faces).not_to include(@other_whiteboards_new_face)
      end
    end

    context "When I present the whiteboard" do
      before do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)
      end

      specify "Then I should see my whiteboard's past, 'now', and future new faces" do
        expect(@now_whiteboard.new_faces).to include(@now_new_face, @past_new_face, @future_new_face)
      end
      
      specify "But I should not see new faces for other whiteboards" do
        expect(@now_whiteboard.new_faces).not_to include(@other_whiteboards_new_face)
      end
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' new faces on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)

        expect(@now_whiteboard.new_faces).not_to include(@past_new_face, @now_new_face)
        expect(@now_whiteboard.new_faces).to include(@future_new_face)
      end

      specify "Then I should not see any new faces on the current standup" do
        present_standup = present_standup(whiteboard: @my_whiteboard, date: @now)

        expect(present_standup.new_faces).to be_empty
      end

      specify "But I should still new future new faces on the future standup" do
        future_standup = present_standup(whiteboard: @my_whiteboard, date: @future)

        expect(future_standup.new_faces).to include(@future_new_face)
      end
    end
  end
  
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:help_repo) { repo_factory.help_repo }
  let(:whiteboard_repo) { repo_factory.whiteboard_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_new_face(whiteboard:, date:)
    Board.create_new_face(
      observer: observer,
      attributes: valid_new_face_attributes.merge(date: date),
      new_face_repo: new_face_repo,
      whiteboard_id: whiteboard.id,
    ).execute

    observer.spy_created_new_face
  end

  def create_whiteboard
    Board.create_whiteboard(
      observer: observer,
      attributes: valid_whiteboard_attributes,
      whiteboard_repo: whiteboard_repo,
    ).execute

    observer.spy_created_whiteboard
  end

  def present_standup(whiteboard:, date:)
    Board.present_standup(
      whiteboard_id: whiteboard.id,
      repo_factory: repo_factory,
      observer: observer,
      date: date,
    ).execute

    observer.spy_presented_standup
  end

  def present_whiteboard(whiteboard:)
    Board.present_whiteboard_items(
      whiteboard_id: whiteboard.id,
      repo_factory: repo_factory,
      observer: observer,
    ).execute

    observer.spy_presented_whiteboard_items
  end

  def archive_standup(whiteboard_id, date)
    Board.archive_standup(
      whiteboard_id: whiteboard_id,
      date: date,
      repo_factory: repo_factory,
      observer: observer,
    ).execute
  end
end
