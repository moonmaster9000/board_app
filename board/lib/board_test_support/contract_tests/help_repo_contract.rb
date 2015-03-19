require "board/entities/help"
require "board_test_support/contract_tests/entity_that_belongs_to_team_repo_contract"

def assert_works_like_help_repo(help_repo_factory:)
  assert_works_like_an_entity_repo_that_belongs_to_team(
    entity_repo_factory: help_repo_factory,
    entity_class: Board::Entities::Help
  )
end
