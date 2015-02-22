require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/doubles/fake_new_face_repo"
require "board/entities/new_face"

assert_works_like_an_entity_repo(
  entity_repo_factory:  -> { FakeNewFaceRepo.new },
  entity_factory:       -> { Board::Entities::NewFace.new }
)


