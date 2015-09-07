require "board/contracts/repo_contracts/standup_email_config_repo_contract"
require "support/doubles/fake_repo_factory"

verify_standup_email_config_repo_contract(
  repo_factory: FakeRepoFactory.new
)
