require "active_record_spec_helper"
require "persistence/repos/repo_factory"
require "board_test_support/repo_contracts/whiteboard_repo_contract"

assert_works_like_a_whiteboard_repo(
  repo_factory:  Persistence::Repos::RepoFactory.new,
)
