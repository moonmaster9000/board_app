require "support/doubles/fake_repo_factory"
require "board/contracts/repo_contracts/help_repo_contract"

assert_works_like_help_repo(
  repo_factory: FakeRepoFactory.new
)
