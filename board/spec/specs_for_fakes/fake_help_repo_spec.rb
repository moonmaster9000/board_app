require "support/doubles/fake_repo_factory"
require "board/contracts/repo_contracts/help_repo_contract"

verify_help_repo_contract(
  repo_factory: FakeRepoFactory.new
)
