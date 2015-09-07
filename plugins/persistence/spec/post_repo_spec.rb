require "board/contracts/repo_contracts/post_repo_contract"
require "active_record_spec_helper"
require "persistence/repos/repo_factory"

verify_post_repo_contract(repo_factory: Persistence::Repos::RepoFactory.new)
