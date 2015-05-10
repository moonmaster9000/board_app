require "board/entities/interesting"
require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/contract_tests/entity_that_belongs_to_team_repo_contract"

def assert_works_like_interesting_repo(repo_factory:)
  interesting_repo_lambda = -> { repo_factory.interesting_repo }
  interesting_class       = Board::Entities::Interesting

  assert_works_like_an_entity_repo(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

  assert_works_like_an_entity_repo_that_belongs_to_team(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

end
