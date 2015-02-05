require "board/entities/team"

module Board
  extend self

  def create_team(*args)
    CreateTeamUseCase.new(*args)
  end

  def present_team(*args)
    PresentTeamUseCase.new(*args)
  end

  class PresentTeamUseCase
    def initialize(observer:,team_id:,team_repo:)
      @team_repo = team_repo
      @observer = observer
      @team_id = team_id
    end

    def execute
      team = @team_repo.find(@team_id)
      @observer.team_presented(team)
    end
  end

  class CreateTeamUseCase
    def initialize(observer:, attributes:, team_repo:)
      @observer = observer
      @team_repo = team_repo
      @attributes = attributes
    end

    def execute
      if valid?
        persist
        notify_observer_of_success
      else
        notify_observer_of_failures
      end
    end

    def notify_observer_of_success
      @observer.team_created(team)
    end

    def persist
      @team_repo.save(team)
    end

    def team
      @team ||= Entities::Team.new(@attributes)
    end

    def notify_observer_of_failures
      @observer.validation_failed(team.validation_errors)
    end

    def valid?
      team.valid?
    end

    private


  end
end
