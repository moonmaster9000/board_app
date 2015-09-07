require "active_record_spec_helper"
require "persistence/repos/repo_factory"
require "board/contracts/repo_contracts/whiteboard_repo_contract"

verify_whiteboard_repo_contract(
  repo_factory:  Persistence::Repos::RepoFactory.new,
)
