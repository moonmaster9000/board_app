require "board/contracts/repo_contracts/interesting_repo_contract"
require "support/doubles/fake_repo_factory"

verify_interesting_repo_contract(
  repo_factory: FakeRepoFactory.new
)
