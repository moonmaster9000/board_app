require "board/entities/event"
require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/contract_tests/entity_that_belongs_to_team_repo_contract"

def assert_works_like_event_repo(repo_factory:)
  event_repo_lambda = -> { repo_factory.event_repo }
  event_class       = Board::Entities::Event

  assert_works_like_an_entity_repo(
    generate_repo_lambda: event_repo_lambda,
    entity_class: event_class,
  )

  assert_works_like_an_entity_repo_that_belongs_to_team(
    generate_repo_lambda: event_repo_lambda,
    entity_class: event_class,
  )

end
