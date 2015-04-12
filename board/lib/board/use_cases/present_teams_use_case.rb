module Board
  class PresentTeamsUseCase
    def initialize(observer:,team_repo:)
      @observer = observer
      @team_repo = team_repo
    end

    def execute
      teams = @team_repo.all
      @observer.teams_presented(teams)
    end
  end
end
