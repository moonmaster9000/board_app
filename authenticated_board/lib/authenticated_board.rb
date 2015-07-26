module AuthenticatedBoard
  class UseCaseFactory
    def authenticate(*args)
      AuthenticateUseCase.new(*args)
    end
  end

  class AuthenticateUseCase
    def initialize(observer:, session:, authentication_strategy:)
      @observer = observer
      @session = session
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
      @session.log_in(user)
      @observer.authentication_succeeded
    end

    def authentication_failed(errors)
      @observer.authentication_failed(convert_errors_hash_to_errors(errors))
    end

    def convert_errors_hash_to_errors(errors)
      errors.map { |name, code| Error.new(name, code) }
    end

    private

    def notify_already_authenticated
      @observer.already_authenticated
    end

    def already_authenticated?
      @session.logged_in?
    end

    def execute_strategy_and_listen_for_results
      @authentication_strategy.execute(observer: self)
    end

    class Error < Struct.new(:name, :code)
    end
  end
end

