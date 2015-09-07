require "board/use_cases/helps/entities/help"
require "board/contracts/repo_contracts/private/entity_that_belongs_to_whiteboard_repo_contract"
require "board/contracts/repo_contracts/private/entity_repo_contract"

def verify_help_repo_contract(repo_factory:)
  help_repo_lambda = -> { repo_factory.help_repo }
  help_class       = Board::Entities::Help

  verify_entity_repo_contract(
    generate_repo_lambda: help_repo_lambda,
    entity_class: help_class,
  )

  verify_whiteboard_entity_contract(
    generate_repo_lambda: help_repo_lambda,
    entity_class: help_class,
  )
end
