require "board/use_cases/whiteboards/entities/whiteboard"
require "board/contracts/repo_contracts/entity_repo_contract"

def verify_whiteboard_repo_contract(repo_factory:)
  verify_entity_repo_contract(
    generate_repo_lambda:  -> { repo_factory.whiteboard_repo },
    entity_class:          Board::Entities::Whiteboard,
  )
end

