require "board/contracts/repo_contracts/whiteboard_repo_contract"
require "support/doubles/fake_repo_factory"

verify_whiteboard_repo_contract(
  repo_factory:  FakeRepoFactory.new,
)
