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
        if @repo_factory.session_repo.logged_in?
          @observer.already_authenticated
        else
          @authentication_strategy.execute(observer: self)
        end
      end

      def authentication_succeeded(user)
        @repo_factory.session_repo.log_in(user)
        @observer.authentication_succeeded
      end
    end
  end
end
