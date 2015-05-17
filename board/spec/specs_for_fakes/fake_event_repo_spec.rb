require "board_test_support/contract_tests/event_repo_contract"
require "board_test_support/doubles/fake_repo_factory"

assert_works_like_event_repo(
  repo_factory: FakeRepoFactory.new
)
