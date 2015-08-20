require "board/use_cases/new_faces/entities/new_face"
require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/contract_tests/entity_that_belongs_to_whiteboard_repo_contract"

def assert_works_like_a_new_face_repo(repo_factory:)
  new_face_repo_lambda = -> { repo_factory.new_face_repo }
  new_face_class       = Board::Entities::NewFace

  assert_works_like_an_entity_repo(
    generate_repo_lambda: new_face_repo_lambda,
    entity_class: new_face_class,
  )

  assert_works_like_an_entity_repo_that_belongs_to_whiteboard(
    generate_repo_lambda: new_face_repo_lambda,
    entity_class: new_face_class,
  )
end

