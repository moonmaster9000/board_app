require "board/contracts/repo_contracts/event_repo_contract"
require "support/doubles/fake_repo_factory"

verify_event_repo_contract(
  repo_factory: FakeRepoFactory.new
)
