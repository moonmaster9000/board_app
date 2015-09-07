require "authenticated_board/contracts/session_contract"
require "web/cookie_session"

verify_session_contract(session_factory: ->{ Web::CookieSession.new })
