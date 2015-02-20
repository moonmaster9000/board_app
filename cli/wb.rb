#!/usr/bin/env ruby

require 'thor'
require 'board'
require 'board_test_support/doubles/fake_team_repo'

class MyCLI < Thor
  module CLIObserver
    extend self

    def team_created(team)
      puts "Created team #{team.name}"
    end
  end

  desc "create_team", "Interactively create a team"
  def create_team
    team_name = ask("Enter your team name: ")
    Board.create_team(
        observer: CLIObserver,
        team_repo: team_repo,
        attributes: {name: team_name}
    ).execute
  end

  private

  def team_repo
    FakeTeamRepo.new
  end
end

MyCLI.start(ARGV)