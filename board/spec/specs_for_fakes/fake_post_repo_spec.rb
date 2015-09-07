require "support/doubles/fake_repo_factory"
require "board/contracts/repo_contracts/post_repo_contract"

verify_post_repo_contract(repo_factory: FakeRepoFactory.new)
