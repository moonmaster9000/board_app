require "board_test_support/doubles/fake_repo_factory"
require "board_test_support/contract_tests/post_repo_contract"

assert_works_like_a_post_repo(repo_factory: FakeRepoFactory.new)
