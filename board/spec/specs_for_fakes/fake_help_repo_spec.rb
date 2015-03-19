require "board_test_support/doubles/fake_help_repo"
require "board_test_support/contract_tests/help_repo_contract"

assert_works_like_help_repo(
  help_repo_factory: -> { FakeHelpRepo.new }
)
