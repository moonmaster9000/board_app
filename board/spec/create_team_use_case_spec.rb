require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_whiteboard_repo"
require "board_test_support/test_attributes"
require "support/common_assertions"

describe "USE CASE: Create Whiteboard" do
  include TestAttributes
  include CommonAssertions

  context "Given an empty whiteboard name" do
    let(:attributes) do
      valid_whiteboard_attributes.merge(name: "")
    end

    context "When I use the create_whiteboard use case with that empty whiteboard name" do
      before do
        create_whiteboard
      end

      specify "Then it should tell the observer that name is required" do
        assert_observer_got_one_error(gui, :name, :required)
      end
    end
  end

  context "Given a valid whiteboard name" do
    let(:attributes) { valid_whiteboard_attributes }

    context "When I use the create_whiteboard use case with that valid whiteboard name" do
      before do
        create_whiteboard
      end

      specify "Then it should create a whiteboard with the requested attributes" do
        expect(gui.spy_created_whiteboard.name).to eq(attributes[:name])
      end

      specify "Then it should save the whiteboard so that we can use it later" do
        present_whiteboard
        expect(gui.spy_presented_whiteboard).to eq(gui.spy_created_whiteboard)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:whiteboard_repo) { FakeWhiteboardRepo.new }

  def create_whiteboard
    Board.create_whiteboard(
      attributes: attributes,
      observer: gui,
      whiteboard_repo: whiteboard_repo
    ).execute
  end

  def present_whiteboard
    Board.present_whiteboard(
      observer: gui,
      whiteboard_id: gui.spy_created_whiteboard.id,
      whiteboard_repo: whiteboard_repo
    ).execute
  end
end
