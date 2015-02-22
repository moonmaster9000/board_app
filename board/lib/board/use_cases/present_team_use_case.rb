module Board
  module UseCases
    class PresentTeamUseCase
      def initialize(observer:, team_id:, team_repo:)
        @team_repo = team_repo
        @observer = observer
        @team_id = team_id
      end

      def execute
        team = @team_repo.find(@team_id)
        @observer.team_presented(team)
      end
    end
  end
end
