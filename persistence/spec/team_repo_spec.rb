require "active_record_spec_helper"
require "persistence/repos/team_repo"
require "board_test_support/contract_tests/entity_repo_contract"
require "board/entities/team"

assert_works_like_an_entity_repo(
  entity_repo_factory:  -> { Persistence::Repos::TeamRepo.new },
  entity_factory:       -> { Board::Entities::Team.new },
)
