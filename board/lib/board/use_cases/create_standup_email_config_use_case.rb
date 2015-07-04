require "board/use_cases/create_entity_for_whiteboard_use_case"
require "board/entities/standup_email_config"

module Board
  module UseCases
    class CreateStandupEmailConfigUseCase < CreateEntityForWhiteboardUseCase
      def initialize(whiteboard_id:, attributes:, observer:, repo_factory:)
        super(
          whiteboard_id: whiteboard_id,
          repo: repo_factory.standup_email_config_repo,
          attributes: attributes,
          observer: observer,
          entity_class: Entities::StandupEmailConfig,
        )
      end

      def execute
        if email_config_already_exists?
          tell_observer_dupes_not_allowed
        else
          super
        end
      end

      private

      def tell_observer_dupes_not_allowed
        @observer.standup_email_config_already_exists
      end

      def email_config_already_exists?
        @repo.find_by_whiteboard_id(@whiteboard_id)
      end
    end
  end
end
