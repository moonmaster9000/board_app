require "board/entities/interesting"
require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/contract_tests/entity_that_belongs_to_team_repo_contract"

def assert_works_like_interesting_repo(interesting_repo_factory:)
  assert_works_like_an_entity_repo(
    entity_repo_factory:  -> { interesting_repo_factory.call },
    entity_factory:       -> { Board::Entities::Interesting.new },
  )

  assert_works_like_an_entity_repo_that_belongs_to_team(
    entity_repo_factory: interesting_repo_factory,
    entity_class: Board::Entities::Interesting
  )
end
