require "board_test_support/contract_tests/session_repo_contract"
require "board_test_support/doubles/fake_session_repo"

assert_works_like_session_repo(session_repo_factory: -> { FakeSessionRepo.new })
