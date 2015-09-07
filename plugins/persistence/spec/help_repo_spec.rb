require "active_record_spec_helper"
require "persistence/repos/repo_factory"
require "board/contracts/repo_contracts/help_repo_contract"

verify_help_repo_contract(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
