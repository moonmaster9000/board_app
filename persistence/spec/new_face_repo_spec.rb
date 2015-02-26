require "board_test_support/contract_tests/new_face_repo_contract"
require "active_record_spec_helper"
require "persistence/repos/new_face_repo"

assert_works_like_a_new_face_repo(new_face_repo_factory: -> { Persistence::Repos::NewFaceRepo.new })
