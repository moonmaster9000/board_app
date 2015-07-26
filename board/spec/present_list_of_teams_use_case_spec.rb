require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_whiteboard_repo"
require "board_test_support/test_attributes"

describe "USE CASE: Present a list of Whiteboards" do
  include TestAttributes

  context "Given a valid whiteboard" do
    before do
      create_whiteboard
    end

    context "When I execute the present_whiteboard use case with that whiteboard's id" do
      before do
        present_whiteboards
      end

      specify "Then it sends a presentable whiteboard to the gui" do
        expect(presented_whiteboards).to include(created_whiteboard)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:whiteboard_repo) { FakeWhiteboardRepo.new }
  let(:created_whiteboard) { gui.spy_created_whiteboard }
  let(:presented_whiteboards) { gui.spy_presented_whiteboards }

  def create_whiteboard
    Board::UseCaseFactory.new.create_whiteboard(
        attributes: valid_whiteboard_attributes,
        observer: gui,
        whiteboard_repo: whiteboard_repo
    ).execute
  end

  def present_whiteboards
    Board::UseCaseFactory.new.present_whiteboards(
        observer: gui,
        whiteboard_repo: whiteboard_repo
    ).execute
  end
end
