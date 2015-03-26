require "active_record_spec_helper"
require "persistence/repos/repo_factory"
require "board_test_support/contract_tests/help_repo_contract"

assert_works_like_help_repo(
  help_repo_factory: -> { Persistence::Repos::RepoFactory.new.help_repo },
)
