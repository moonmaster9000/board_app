require "support/common_assertions"
require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_interesting_repo"
require "board_test_support/test_attributes"
require "board_test_support/doubles/fake_whiteboard_repo"


describe "USE CASE: creating a interesting" do
  include CommonAssertions
  include TestAttributes

  let(:attributes) { valid_interesting_attributes }

  context "Given a whiteboard exists" do
    before do
      @whiteboard_id = create_whiteboard.id
    end

    context "when the attributes are invalid" do
      context "because the date is blank" do
        let(:attributes) { valid_interesting_attributes.merge(date: nil) }

        it "informs the observer that a date is required" do
          create_interesting(@whiteboard_id)
          assert_gui_got_one_error(:date, :required)
        end
      end

      context "because the title is blank" do
        let(:attributes) { valid_interesting_attributes.merge(title: nil) }

        it "informs the observer that a description is required" do
          create_interesting(@whiteboard_id)
          assert_gui_got_one_error(:title, :required)
        end
      end

      context "because I don't give it a whiteboard_id" do
        let(:whiteboard_id) { nil }

        it "informs the observer that a whiteboard_id is required" do
          create_interesting(whiteboard_id)
          assert_gui_got_one_error(:whiteboard_id, :required)
        end
      end
    end

    context "when the attributes are valid" do
      let(:attributes) { valid_interesting_attributes }

      it "sends a interesting back to the gui with the requested attributes" do
        create_interesting(@whiteboard_id)
        expect(gui.spy_created_interesting.attributes).to include(attributes)
      end

      it "doesn't send any validation errors" do
        create_interesting(@whiteboard_id)
        expect(gui.spy_validation_errors).not_to be
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:fake_interesting_repo) { FakeInterestingRepo.new }
  let(:fake_whiteboard_repo) { FakeWhiteboardRepo.new }
  let(:whiteboard_id) { @whiteboard_id }

  def create_interesting(whiteboard_id)
    Board.create_interesting(
      observer: gui,
      attributes: attributes,
      interesting_repo: fake_interesting_repo,
      whiteboard_id: whiteboard_id,
    ).execute
  end

  def create_whiteboard
    Board.create_whiteboard(
      observer: gui,
      attributes: valid_whiteboard_attributes,
      whiteboard_repo: fake_whiteboard_repo,
    ).execute

    gui.spy_created_whiteboard
  end
end
