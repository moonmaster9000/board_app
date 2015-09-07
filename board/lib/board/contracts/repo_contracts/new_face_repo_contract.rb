require "board/use_cases/new_faces/entities/new_face"
require "board/contracts/repo_contracts/private/entity_repo_contract"
require "board/contracts/repo_contracts/private/entity_that_belongs_to_whiteboard_repo_contract"

def verify_new_face_repo_contract(repo_factory:)
  new_face_repo_lambda = -> { repo_factory.new_face_repo }
  new_face_class       = Board::Entities::NewFace

  verify_entity_repo_contract(
    generate_repo_lambda: new_face_repo_lambda,
    entity_class: new_face_class,
  )

  verify_whiteboard_entity_contract(
    generate_repo_lambda: new_face_repo_lambda,
    entity_class: new_face_class,
  )
end

