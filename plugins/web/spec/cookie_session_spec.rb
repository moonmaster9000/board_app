require "authenticated_board/contracts/session_contract"
require "web/cookie_session"

assert_works_like_session(session_factory: ->{ Web::CookieSession.new })
