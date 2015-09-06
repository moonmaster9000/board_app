require "board"
require "support/doubles/gui_spy"
require "support/doubles/fake_whiteboard_repo"
require "support/test_attributes"

describe "USE CASE: Present Whiteboard" do
  include TestAttributes

  context "Given a valid whiteboard" do
    before do
      create_whiteboard
    end

    context "When I execute the present_whiteboard use case with that whiteboard's id" do
      before do
        present_whiteboard(created_whiteboard.id)
      end

      specify "Then it sends a presentable whiteboard to the gui" do
        expect(whiteboard_presented_to_gui).to eq(created_whiteboard)
      end
    end
  end

  let(:gui) { GuiSpy.new }
  let(:whiteboard_repo) { FakeWhiteboardRepo.new }
  let(:created_whiteboard) { gui.spy_created_whiteboard }
  let(:whiteboard_presented_to_gui) { gui.spy_presented_whiteboard }

  def create_whiteboard
    Board::UseCaseFactory.new.create_whiteboard(
      attributes: valid_whiteboard_attributes,
      observer: gui,
      whiteboard_repo: whiteboard_repo
    ).execute
  end

  def present_whiteboard(created_whiteboard_id)
    Board::UseCaseFactory.new.present_whiteboard(
      observer: gui,
      whiteboard_id: created_whiteboard_id,
      whiteboard_repo: whiteboard_repo
    ).execute
  end
end
