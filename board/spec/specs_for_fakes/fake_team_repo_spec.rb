require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/doubles/fake_team_repo"
require "board/entities/team"

assert_works_like_an_entity_repo(
  entity_repo_factory:  -> { FakeTeamRepo.new },
  entity_factory:       -> { Board::Entities::Team.new }
)
