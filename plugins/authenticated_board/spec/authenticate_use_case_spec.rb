require "authenticated_board"
require "doubles/fake_session"

describe "USE CASE: Authenticate" do
  context "Given the session is not already authenticated" do
    context "When the authentication strategy succeeds and returns a user" do
      let(:authentication_strategy) { AlwaysSucceedsAuthStrategyStub.new }

      specify "Then the Authenticate use case saves the stubbed_user in the session" do
        authenticate(authentication_strategy: authentication_strategy)

        expect(session.logged_in?).to be(true)
      end

      specify "It notifies the observer that authentication succeeded" do
        authenticate(authentication_strategy: authentication_strategy)

        expect(observer.spy_authentication_succeeded).to be(true)
      end
    end
  end

  context "Given the session is already authenticated" do
    before do
      @authentication_strategy = AlwaysSucceedsAuthStrategyStub.new
      authenticate(authentication_strategy: @authentication_strategy)
    end

    context "When authentication is reattempted" do
      before do
        authenticate(authentication_strategy: @authentication_strategy)
      end

      specify "Then the Authenticate use case tells the observer that the session is already authenticated" do
        expect(observer.spy_already_authenticated).to be(true)
      end
    end
  end

  context "When the authentication strategy fails and returns errors" do
    let(:authentication_strategy) { AlwaysFailsAuthStrategyStub.new }

    specify "Then the Authenticate use case should forward those errors to the observer" do
      authenticate(authentication_strategy: authentication_strategy)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  let(:observer) { AuthenticateObserverSpy.new }
  let(:session) { FakeSession.new }

  def authenticate(authentication_strategy:)
    AuthenticatedBoard::UseCaseFactory.new.authenticate(
      authentication_strategy: authentication_strategy,
      session: session,
      observer: observer,
    ).execute
  end

  class AuthenticateObserverSpy
    def authentication_succeeded
      @spy_authentication_succeeded = true
    end
    attr_reader :spy_authentication_succeeded

    def authentication_failed
      @spy_authentication_failed = true
    end
    attr_reader :spy_authentication_failed

    def already_authenticated
      @spy_already_authenticated = true
    end
    attr_reader :spy_already_authenticated
  end

  class AlwaysSucceedsAuthStrategyStub
    def execute(observer:)
      observer.authentication_succeeded
    end
  end

  class AlwaysFailsAuthStrategyStub
    def execute(observer:)
      observer.authentication_failed
    end
  end
end
