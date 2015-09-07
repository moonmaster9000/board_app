require "board/use_cases/interestings/entities/interesting"
require "board_test_support/repo_contracts/entity_repo_contract"
require "board_test_support/repo_contracts/entity_that_belongs_to_whiteboard_repo_contract"

def assert_works_like_interesting_repo(repo_factory:)
  interesting_repo_lambda = -> { repo_factory.interesting_repo }
  interesting_class       = Board::Entities::Interesting

  assert_works_like_an_entity_repo(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

  assert_works_like_an_entity_repo_that_belongs_to_whiteboard(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

end
