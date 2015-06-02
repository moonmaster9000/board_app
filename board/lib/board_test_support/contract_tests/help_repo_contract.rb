require "board/entities/help"
require "board_test_support/contract_tests/entity_that_belongs_to_whiteboard_repo_contract"
require "board_test_support/contract_tests/entity_repo_contract"

def assert_works_like_help_repo(repo_factory:)
  help_repo_lambda = -> { repo_factory.help_repo }
  help_class       = Board::Entities::Help

  assert_works_like_an_entity_repo(
    generate_repo_lambda: help_repo_lambda,
    entity_class: help_class,
  )

  assert_works_like_an_entity_repo_that_belongs_to_whiteboard(
    generate_repo_lambda: help_repo_lambda,
    entity_class: help_class,
  )
end
