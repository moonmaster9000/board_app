require "board/entities/new_face"
require "board_test_support/doubles/fake_new_face_repo"

describe "New Face Repo" do
  context "When I tell the repo to save some new faces" do
    let(:new_face_1) { create_new_face }
    let(:new_face_2) { create_new_face }

    specify "Then the repo should give them unique ids" do
      expect(new_face_2.id).not_to eq(new_face_1.id)
    end

    specify "And the repo should allow me to fetch the new faces by their ID" do
      expect(new_face_repo.find(new_face_1.id)).to eq(new_face_1)
    end
  end

  let(:new_face_repo) { FakeNewFaceRepo.new }

  def create_new_face
    new_face = Board::Entities::NewFace.new
    new_face_repo.save(new_face)
    new_face
  end
end
