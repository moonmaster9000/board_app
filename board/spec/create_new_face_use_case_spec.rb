require "date"
require "board"
require "board_test_support/doubles/gui_spy"
require "board_test_support/test_attributes"
require "board_test_support/doubles/fake_whiteboard_repo"
require "board_test_support/doubles/fake_new_face_repo"
require "support/common_assertions"

describe "USE CASE: Create New Face" do
  include TestAttributes
  include CommonAssertions

  context "Given a whiteboard exists" do
    before do
      create_whiteboard
    end

    context "Given valid new face attributes" do
      let(:new_face_attributes) { valid_new_face_attributes }

      context "When a new face is created for that whiteboard" do
        before do
          create_new_face(new_face_attributes, gui.spy_created_whiteboard.id)
        end

        specify "the use case sends the new face back to the observer" do
          expect(gui.spy_created_new_face.attributes).to include(new_face_attributes)
        end

        specify "the use case persists the new face" do
          expect(new_face_repo.all).to include(gui.spy_created_new_face)
        end

        specify "the use case associates the new face with the requested whiteboard" do
          # this test is coupled to implementation
          expect(gui.spy_created_new_face.whiteboard_id).to eq(gui.spy_created_whiteboard.id)
        end
      end
    end

    context "Given an empty name" do
      let(:new_face_attributes) { valid_new_face_attributes.merge(name: "") }

      context "When a new face is created for that whiteboard" do
        before do
          create_new_face(new_face_attributes, gui.spy_created_whiteboard.id)
        end

        specify "the use case tells the observer that creation failed because the name is required" do
          assert_gui_got_one_error(:name, :required)
        end
      end
    end

    context "Given no date" do
      let(:new_face_attributes) { valid_new_face_attributes.merge(date: nil) }

      context "When a new face is created for that whiteboard" do
        before do
          create_new_face(new_face_attributes, gui.spy_created_whiteboard.id)
        end

        specify "the use case tells the observer that creation failed because a date is required" do
          assert_gui_got_one_error(:date, :required)
        end
      end
    end

    let(:gui) { GuiSpy.new }
    let(:whiteboard_repo) { FakeWhiteboardRepo.new }
    let(:new_face_repo) { FakeNewFaceRepo.new }
    let(:valid_new_face_attributes) { TestAttributes.valid_new_face_attributes }

    def create_whiteboard
      Board.create_whiteboard(
        attributes: valid_whiteboard_attributes,
        observer: gui,
        whiteboard_repo: whiteboard_repo
      ).execute
    end

    def create_new_face(new_face_attributes, whiteboard_id)
      Board.create_new_face(observer: gui,
        whiteboard_id: whiteboard_id,
        new_face_repo: new_face_repo,
        attributes: new_face_attributes).execute
    end

  end
end
