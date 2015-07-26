require "authenticated_board_test_support/contract_tests/session_contract"
require "doubles/fake_session"

assert_works_like_session_repo(
  session_repo_factory: -> { FakeSession.new },
)
