require "authenticated_board_contracts/session_contract"
require "web/cookie_session"

assert_works_like_session(session_factory: ->{ Web::CookieSession.new })
