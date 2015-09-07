require "active_record_spec_helper"
require "board/contracts/repo_contracts/interesting_repo_contract"
require "persistence/repos/repo_factory"

verify_interesting_repo_contract(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
