require "doubles/fake_session"
require "authenticated_board"

describe "use cases require authentication" do
  context "when the session is not logged in" do

    specify "then the use case factory tells the observer to log in" do
      use_case_factory.stub_use_case(session: session, observer: observer).execute

      expect(observer.spy_authentication_required).to be(true)
    end
  end

  context "When the session is logged in" do
    before do
      session.log_in("user stub")
    end

    specify "then the authentication_board use case factory allows the underlying use cases to be executed" do
      use_case_factory.stub_use_case(session: session, observer: observer).execute

      expect(use_case_spy.execute_was_called?).to be(true)
    end
  end

  let(:session) { FakeSession.new }

  let(:use_case_factory) { AuthenticatedBoard::UseCaseFactory.new(board_use_case_factory: stubbed_board_use_case_factory)}
  let(:use_case_spy) { UseCaseSpy.new }
  let(:observer) { AuthenticationObserverSpy.new }
  let(:stubbed_board_use_case_factory) do
    stubbed_use_case = use_case_spy

    Class.new do
      define_method(:stub_use_case) do |*|
        stubbed_use_case
      end
    end.new
  end

  class UseCaseSpy
    def execute
      @execute_was_called = true
    end

    def execute_was_called?
      !!@execute_was_called
    end
  end

  class AuthenticationObserverSpy
    def authentication_required
      @spy_authentication_required = true
    end
    attr_reader :spy_authentication_required
  end
end
