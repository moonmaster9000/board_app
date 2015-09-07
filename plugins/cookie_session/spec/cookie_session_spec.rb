require "cookie_session"
require "authenticated_board/contracts/session_contract"

verify_session_contract(session_factory: ->{ CookieSession.new })
