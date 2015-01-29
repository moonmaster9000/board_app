module Board
  extend self

  def create_team(name:,observer:)
    CreateTeamUseCase.new(observer: observer, name: name)
  end

  class CreateTeamUseCase
    def initialize(observer:, name:)
      @observer = observer
      @name = name
    end

    def execute
      if @name.empty?
        @observer.validation_failed(["name is required"])
      else
        @observer.team_created(Team.new(name: @name))
      end
    end

    private


    class Team
      attr_reader :name

      def initialize(name:)
        @name = name
      end
    end
  end
end
