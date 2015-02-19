require "persistence/repos/team_repo"
require "board_test_support/contract_tests/team_repo"

assert_works_like_a_team_repo(-> { Persistence::Repos::TeamRepo.new })
