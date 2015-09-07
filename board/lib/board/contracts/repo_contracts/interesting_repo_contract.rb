require "board/use_cases/interestings/entities/interesting"
require "board/contracts/repo_contracts/entity_repo_contract"
require "board/contracts/repo_contracts/entity_that_belongs_to_whiteboard_repo_contract"

def verify_interesting_repo_contract(repo_factory:)
  interesting_repo_lambda = -> { repo_factory.interesting_repo }
  interesting_class       = Board::Entities::Interesting

  verify_entity_repo_contract(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

  verify_whiteboard_entity_contract(
    generate_repo_lambda: interesting_repo_lambda,
    entity_class: interesting_class,
  )

end
