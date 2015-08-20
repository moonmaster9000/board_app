require "board_test_support/contract_tests/post_repo_contract"
require "active_record_spec_helper"
require "persistence/repos/repo_factory"

assert_works_like_a_post_repo(repo_factory: Persistence::Repos::RepoFactory.new)
