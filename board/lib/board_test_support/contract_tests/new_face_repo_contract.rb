require "board/entities/new_face"
require "board_test_support/contract_tests/entity_repo_contract"

def assert_works_like_a_new_face_repo(new_face_repo_factory:)
  assert_works_like_an_entity_repo(
    entity_repo_factory:  -> { new_face_repo_factory.call },
    entity_factory:       -> { Board::Entities::NewFace.new },
  )


  describe "New Face Repo" do
    context "Given new faces for different teams" do
      before do
        new_face_repo.save(team_1_new_face)
        new_face_repo.save(team_2_new_face)
      end

      it "should fetch new faces by team" do
        new_faces_for_team_1 = new_face_repo.all_by_team_id(1)

        expect(new_faces_for_team_1).to include team_1_new_face
        expect(new_faces_for_team_1).not_to include team_2_new_face
      end
    end

    let(:team_1_new_face) { Board::Entities::NewFace.new(team_id: 1) }
    let(:team_2_new_face) { Board::Entities::NewFace.new(team_id: 2) }
    let(:new_face_repo) { new_face_repo_factory.call }
  end
end

