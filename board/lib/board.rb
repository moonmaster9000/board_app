require "board/entities/team"
require "board/entities/new_face"

module Board
  extend self

  def create_team(*args)
    CreateTeamUseCase.new(*args)
  end

  def present_team(*args)
    PresentTeamUseCase.new(*args)
  end

  def create_new_face(*args)
    CreateNewFaceUseCase.new(*args)
  end

  def present_standup(*args)
    PresentStandupUseCase.new(*args)
  end

  class PresentStandupUseCase
    module Values
      class Standup
        attr_reader :new_faces

        def initialize(new_faces:)
          @new_faces = new_faces
        end
      end
    end

    def initialize(team_id:, new_face_repo:, observer:)
      @observer = observer
      @new_face_repo = new_face_repo
      @team_id = team_id
    end

    def execute
      standup = Values::Standup.new(new_faces: @new_face_repo.all)
      @observer.standup_presented(standup)
    end
  end

  class CreateNewFaceUseCase
    def initialize(team_id:, new_face_repo:, attributes:, observer:)
      @team_id = team_id
      @new_face_repo = new_face_repo
      @attributes = attributes
      @observer = observer
    end

    def execute
      new_face = Entities::NewFace.new(@attributes)

      if new_face.valid?
        @new_face_repo.save(new_face)
        @observer.new_face_created(new_face)
      else
        @observer.validation_failed(new_face.validation_errors)
      end

    end
  end

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
