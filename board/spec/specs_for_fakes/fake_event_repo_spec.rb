require "board/contracts/repo_contracts/event_repo_contract"
require "support/doubles/fake_repo_factory"

assert_works_like_event_repo(
  repo_factory: FakeRepoFactory.new
)
