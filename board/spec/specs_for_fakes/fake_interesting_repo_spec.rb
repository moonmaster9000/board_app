require "board_test_support/doubles/fake_interesting_repo"
require "board_test_support/contract_tests/interesting_repo_contract"

assert_works_like_interesting_repo(
  interesting_repo_factory: -> { FakeInterestingRepo.new }
)
