require "active_record_spec_helper"
require "persistence/repos/team_repo"
require "board_test_support/contract_tests/team_repo_contract"

assert_works_like_a_team_repo(
  team_repo_factory:  -> { Persistence::Repos::TeamRepo.new },
)
