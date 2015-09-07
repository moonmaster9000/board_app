require "support/doubles/fake_repo_factory"
require "board/contracts/repo_contracts/post_repo_contract"

assert_works_like_a_post_repo(repo_factory: FakeRepoFactory.new)
