require "board/entities/validations"
require "board/entities/help"

module Board
  module UseCases
    class CreateHelpUseCase
      def initialize(attributes:, help_repo:, observer:, team_id:)
        @observer = observer
        @help_repo = help_repo
        @attributes = attributes
        @team_id = team_id
      end

      def execute
        help = Entities::Help.new(@attributes.merge(team_id: @team_id))

        if (help.valid?)
          @help_repo.save(help)
          @observer.help_created(help)
        else
          @observer.validation_failed(help.validation_errors)
        end
      end
    end
  end
end
