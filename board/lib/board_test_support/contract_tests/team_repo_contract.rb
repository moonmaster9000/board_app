require "board/entities/team"
require "board_test_support/contract_tests/entity_repo_contract"

def assert_works_like_a_team_repo(team_repo_factory:)
  assert_works_like_an_entity_repo(
    entity_repo_factory:  -> { team_repo_factory.call },
    entity_factory:       -> { Board::Entities::Team.new },
  )
end

