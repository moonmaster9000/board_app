require "board/use_cases/events/entities/event"
require "board/contracts/repo_contracts/private/entity_repo_contract"
require "board/contracts/repo_contracts/private/entity_that_belongs_to_whiteboard_repo_contract"

def verify_event_repo_contract(repo_factory:)
  event_repo_lambda = -> { repo_factory.event_repo }
  event_class       = Board::Entities::Event

  verify_entity_repo_contract(
    generate_repo_lambda: event_repo_lambda,
    entity_class: event_class,
  )

  verify_whiteboard_entity_contract(
    generate_repo_lambda: event_repo_lambda,
    entity_class: event_class,
  )

end
