module Board
  class PresentListOfTeamsUseCase
    def initialize(observer:,team_repo:)
      @observer = observer
      @team_repo = team_repo
    end

    def execute
      teams = @team_repo.all
      @observer.list_of_teams_presented(teams)
    end
  end
end