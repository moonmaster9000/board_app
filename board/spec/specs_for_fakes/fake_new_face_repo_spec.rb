require "board/contracts/repo_contracts/new_face_repo_contract"
require "support/doubles/fake_repo_factory"

assert_works_like_a_new_face_repo(
  repo_factory:  FakeRepoFactory.new,
)


