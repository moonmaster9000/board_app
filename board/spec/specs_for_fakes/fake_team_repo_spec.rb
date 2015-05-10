require "board_test_support/contract_tests/team_repo_contract"
require "board_test_support/doubles/fake_repo_factory"

assert_works_like_a_team_repo(
  repo_factory:  FakeRepoFactory.new,
)
