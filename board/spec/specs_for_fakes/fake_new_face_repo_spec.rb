require "board/contracts/repo_contracts/new_face_repo_contract"
require "support/doubles/fake_repo_factory"

verify_new_face_repo_contract(
  repo_factory:  FakeRepoFactory.new,
)


