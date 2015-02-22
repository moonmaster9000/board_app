require "board_test_support/contract_tests/team_repo"
require "board_test_support/doubles/fake_team_repo"

assert_works_like_a_team_repo(-> { FakeTeamRepo.new })

