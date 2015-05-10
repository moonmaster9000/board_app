require "board_test_support/contract_tests/new_face_repo_contract"
require "board_test_support/doubles/fake_repo_factory"

assert_works_like_a_new_face_repo(
  repo_factory:  FakeRepoFactory.new,
)


