require "authenticated_board/contracts/session_contract"
require "doubles/fake_session"

assert_works_like_session(
  session_factory: -> { FakeSession.new },
)
