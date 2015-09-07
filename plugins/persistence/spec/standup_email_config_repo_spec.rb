require "active_record_spec_helper"
require "board/contracts/repo_contracts/standup_email_config_repo_contract"
require "persistence/repos/repo_factory"

assert_works_like_a_standup_email_config_repo(
  repo_factory: Persistence::Repos::RepoFactory.new,
)
