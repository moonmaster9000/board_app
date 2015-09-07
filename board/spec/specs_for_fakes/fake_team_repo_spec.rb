require "board/contracts/repo_contracts/whiteboard_repo_contract"
require "support/doubles/fake_repo_factory"

assert_works_like_a_whiteboard_repo(
  repo_factory:  FakeRepoFactory.new,
)
