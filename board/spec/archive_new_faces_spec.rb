require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Archive New Faces at Standup and on Whiteboard" do
  context "Given there are past, now, and future new faces for my whiteboard" do
    before do
      @my_whiteboard = create_whiteboard
      @now = Date.today
      @future = @now.next_day
      @past_new_face = create_new_face(whiteboard: @my_whiteboard, date: @now.prev_day)
      @now_new_face = create_new_face(whiteboard: @my_whiteboard, date: @now)
      @future_new_face = create_new_face(whiteboard: @my_whiteboard, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then the observer should be notified that the standup was archived" do
        expect(observer.spy_standup_archived).to be(true)
      end

      specify "Then I should not see the past or 'now' new faces on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)

        expect(@now_whiteboard.new_faces).not_to include(@past_new_face, @now_new_face)
        expect(@now_whiteboard.new_faces).to include(@future_new_face)
      end

      specify "Then I should not see any new faces on the current standup" do
        now_standup = present_standup(whiteboard: @my_whiteboard, date: @now)

        expect(now_standup.new_faces).to be_empty
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
