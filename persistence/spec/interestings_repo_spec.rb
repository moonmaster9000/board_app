require "active_record_spec_helper"
require "board_test_support/contract_tests/interesting_repo_contract"
require "persistence/repos/repo_factory"

assert_works_like_interesting_repo(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
