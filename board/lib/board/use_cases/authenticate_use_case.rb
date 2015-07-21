require "board/entities/standup_email_config"

module Board
  module UseCases
    class AuthenticateUseCase
      def initialize(observer:, repo_factory:, authentication_strategy:)
        @observer = observer
        @repo_factory = repo_factory
        @authentication_strategy = authentication_strategy
      end

      def execute
        if already_authenticated?
          notify_already_authenticated
        else
          execute_strategy_and_listen_for_results
        end
      end

      def authentication_succeeded(user)
        @repo_factory.session_repo.log_in(user)
        @observer.authentication_succeeded
      end

      def authentication_failed(errors)
        @observer.authentication_failed(errors)
      end

      private

      def notify_already_authenticated
        @observer.already_authenticated
      end

      def already_authenticated?
        @repo_factory.session_repo.logged_in?
      end

      def execute_strategy_and_listen_for_results
        @authentication_strategy.execute(observer: self)
      end
    end
  end
end
