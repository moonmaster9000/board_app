require "board"

module AuthenticatedBoard
  class UseCaseFactory
    def initialize(board_use_case_factory: Board::UseCaseFactory.new)
      @board_use_case_factory = board_use_case_factory
    end

    def authenticate(*args)
      AuthenticateUseCase.new(*args)
    end

    def method_missing(use_case_name, session:, observer:, **args, &block)
      board_use_case_args = {observer: observer}.merge(args)
      board_use_case = @board_use_case_factory.send(use_case_name, board_use_case_args, &block)

      RequiresAuthenticationDecorator.new(
        session: session,
        observer: observer,
        use_case: board_use_case
      )
    end

    class RequiresAuthenticationDecorator
      def initialize(session:, observer:, use_case:)
        @session = session
        @observer = observer
        @use_case = use_case
      end

      def execute
        if @session.logged_in?
          @use_case.execute
        else
          @observer.authentication_required
        end
      end
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

    def authentication_succeeded
      @session.log_in
      @observer.authentication_succeeded
    end

    def authentication_failed
      @observer.authentication_failed
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
  end
end

