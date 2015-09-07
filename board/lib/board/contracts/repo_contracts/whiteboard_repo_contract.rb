require "board/use_cases/whiteboards/entities/whiteboard"
require "board/contracts/repo_contracts/entity_repo_contract"

def assert_works_like_a_whiteboard_repo(repo_factory:)
  assert_works_like_an_entity_repo(
    generate_repo_lambda:  -> { repo_factory.whiteboard_repo },
    entity_class:          Board::Entities::Whiteboard,
  )
end

