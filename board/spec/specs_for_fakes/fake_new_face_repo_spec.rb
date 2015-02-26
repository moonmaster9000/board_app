require "board_test_support/contract_tests/new_face_repo_contract"
require "board_test_support/doubles/fake_new_face_repo"

assert_works_like_a_new_face_repo(
  new_face_repo_factory:  -> { FakeNewFaceRepo.new },
)


