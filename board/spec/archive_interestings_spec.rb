require "board"
require "board_test_support/test_attributes"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Present Interestings at Standup" do
  context "Given there are past, now, and future interestings for my whiteboard" do
    before do
      @now = Date.today
      @past = @now.prev_day
      @future = @now.next_day
      
      @my_whiteboard = create_whiteboard
      @past_interesting = create_interesting(whiteboard: @my_whiteboard, date: @past)
      @now_interesting = create_interesting(whiteboard: @my_whiteboard, date: @now)
      @future_interesting = create_interesting(whiteboard: @my_whiteboard, date: @future)
    end

    context "When I archive the 'now' standup" do
      before do
        archive_standup(@my_whiteboard.id, @now)
      end

      specify "Then I should not see the past or 'now' interestings on the whiteboard" do
        @now_whiteboard = present_whiteboard(whiteboard: @my_whiteboard)

        expect(@now_whiteboard.interestings).not_to include(@past_interesting, @now_interesting)
        expect(@now_whiteboard.interestings).to include(@future_interesting)
      end

      specify "Then I should not see any interestings on the current standup" do
        present_standup = present_standup(whiteboard: @my_whiteboard, date: @now)

        expect(present_standup.interestings).to be_empty
      end

      specify "But I should still new future interestings on the future standup" do
        future_standup = present_standup(whiteboard: @my_whiteboard, date: @future)

        expect(future_standup.interestings).to include(@future_interesting)
      end
    end
    
  end

  let(:interesting_repo) { repo_factory.interesting_repo }
  let(:new_face_repo) { repo_factory.new_face_repo }
  let(:whiteboard_repo) { repo_factory.whiteboard_repo }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:observer) { GuiSpy.new }

  include TestAttributes

  def create_interesting(whiteboard:, date:)
    Board.create_interesting(
      observer: observer,
      attributes: valid_interesting_attributes.merge(date: date),
      interesting_repo: interesting_repo,
      whiteboard_id: whiteboard.id,
    ).execute

    observer.spy_created_interesting
  end

  def archive_standup(whiteboard_id, date)
    Board.archive_standup(
      observer: observer,
      repo_factory: repo_factory,
      whiteboard_id: whiteboard_id,
      date: date,
    ).execute
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
      date: date,
      observer: observer,
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
end
