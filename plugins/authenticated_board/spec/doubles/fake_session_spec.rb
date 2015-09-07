require "authenticated_board/contracts/session_contract"
require "doubles/fake_session"

verify_session_contract(
  session_factory: -> { FakeSession.new },
)
