require "board_test_support/contract_tests/interesting_repo_contract"
require "support/doubles/fake_repo_factory"

assert_works_like_interesting_repo(
  repo_factory: FakeRepoFactory.new
)
