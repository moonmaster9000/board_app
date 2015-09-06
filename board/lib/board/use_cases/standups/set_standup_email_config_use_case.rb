require "board/use_cases/standups/entities/standup_email_config"

module Board
  module UseCases
    class SetStandupEmailConfigUseCase
      def initialize(whiteboard_id:, attributes:, observer:, repo_factory:)
        @whiteboard_id = whiteboard_id
        @attributes = attributes
        @observer = observer
        @repo_factory = repo_factory
      end

      def execute
        if valid?
          set_standup_email_config
          notify_observer_of_success
        else
          send_validation_errors_to_observer
        end
      end

      private

      def valid?
        standup_email_config.valid?
      end

      def set_standup_email_config
        @repo_factory.standup_email_config_repo.set(standup_email_config)
      end

      def notify_observer_of_success
        @observer.standup_email_config_created(standup_email_config)
      end

      def standup_email_config
        @standup_email_config ||= Entities::StandupEmailConfig.new(all_attributes)
      end

      def all_attributes
        @attributes.merge(whiteboard_id: @whiteboard_id)
      end

      def send_validation_errors_to_observer
        @observer.validation_failed(standup_email_config.validation_errors)
      end
    end
  end
end

module Board
  class UseCaseFactory
    def create_standup_email_config(*args)
      SetStandupEmailConfigUseCase.new(*args)
    end
  end
end
