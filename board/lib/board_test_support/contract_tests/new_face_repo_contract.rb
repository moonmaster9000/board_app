require "board/entities/new_face"
require "board_test_support/contract_tests/entity_repo_contract"
require "board_test_support/contract_tests/entity_that_belongs_to_team_repo_contract"

def assert_works_like_a_new_face_repo(new_face_repo_factory:)
  assert_works_like_an_entity_repo(
    entity_repo_factory:  -> { new_face_repo_factory.call },
    entity_factory:       -> { Board::Entities::NewFace.new },
  )

  assert_works_like_an_entity_repo_that_belongs_to_team(
    entity_repo_factory: new_face_repo_factory,
    entity_class:        Board::Entities::NewFace,
  )
end

