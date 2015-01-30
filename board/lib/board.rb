require "board/entities/team"

module Board
  extend self

  def create_team(*args)
    CreateTeamUseCase.new(*args)
  end

  class CreateTeamUseCase
    def initialize(observer:, name:, team_repo:)
      @observer = observer
      @name = name
      @team_repo = team_repo
    end

    def execute
      if @name.empty?
        @observer.validation_failed(["name is required"])
      else
        team = Entities::Team.new(name: @name)
        @team_repo.save(team)
        @observer.team_created(team)
      end
    end

    private


  end
end
