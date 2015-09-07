require "board/contracts/repo_contracts/new_face_repo_contract"
require "active_record_spec_helper"
require "persistence/repos/repo_factory"

verify_new_face_repo_contract(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
