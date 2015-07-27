require "authenticated_board_test_support/contract_tests/session_contract"
require "web/cookie_session"

assert_works_like_session(session_factory: ->{ Web::CookieSession.new })
