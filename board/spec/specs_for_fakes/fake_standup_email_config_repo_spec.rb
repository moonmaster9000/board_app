require "board_test_support/contract_tests/standup_email_config_repo_contract"
require "support/doubles/fake_repo_factory"

assert_works_like_a_standup_email_config_repo(
  repo_factory: FakeRepoFactory.new
)
