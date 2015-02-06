require "board/entities/new_face"
require "board_test_support/doubles/fake_new_face_repo"

describe "new_face repo" do
  describe "persisting a new_face" do
    it "should give it a unique id" do
      new_face = create_new_face
      new_face2 = create_new_face

      expect(new_face2.id).not_to eq(new_face.id)
    end

    it "allows a new_face to be fetched at a later" do
      new_face = create_new_face
      expect(new_face_repo.find(new_face.id)).to eq(new_face)
    end
  end

  let(:new_face_repo) { FakeNewFaceRepo.new }

  def create_new_face
    new_face = Board::Entities::NewFace.new
    new_face_repo.save(new_face)
  end
end
