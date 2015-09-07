require "board_test_support/repo_contracts/new_face_repo_contract"
require "active_record_spec_helper"
require "persistence/repos/repo_factory"

assert_works_like_a_new_face_repo(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
