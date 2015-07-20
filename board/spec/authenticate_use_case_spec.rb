require "support/board_test_dsl"
require "board_test_support/doubles/gui_spy"
require "board_test_support/doubles/fake_repo_factory"

describe "USE CASE: Authenticate" do
  context "Given the session is not already authenticated" do
    context "When the authentication strategy succeeds and returns a user" do
      let(:authentication_strategy) { AlwaysSucceedsAuthStrategyStub.new(returns_user: stubbed_user) }

      specify "Then the Authenticate use case saves the stubbed_user in the session" do
        authenticate(authentication_strategy: authentication_strategy)

        expect(session_repo.logged_in_user).to eq(stubbed_user)
      end

      specify "It notifies the observer that authentication succeeded" do
        authenticate(authentication_strategy: authentication_strategy)

        expect(observer.spy_authentication_succeeded).to be(true)
      end
    end
  end

  context "Given the session is already authenticated" do
    before do
      @authentication_strategy = AlwaysSucceedsAuthStrategyStub.new(returns_user: stubbed_user)
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

  let(:stubbed_user) { double :user }
  let(:observer) { GuiSpy.new }
  let(:repo_factory) { FakeRepoFactory.new }
  let(:session_repo) { repo_factory.session_repo }

  def authenticate(authentication_strategy:)
    Board.authenticate(
      authentication_strategy: authentication_strategy,
      repo_factory: repo_factory,
      observer: observer,
    ).execute
  end


  class AlwaysSucceedsAuthStrategyStub
    def initialize(returns_user:)
    @returns_user = returns_user
    end

    def execute(observer:)
      observer.authentication_succeeded(@returns_user)
    end
  end
end
