describe "USE CASE: Authenticate" do
  context "When the authentication strategy succeeds and returns a user" do
    let(:authentication_strategy) { AlwaysSucceedsAuthStrategyStub.new(returns_user: stubbed_user) }

    specify "Then the Authenticate use case saves the stubbed_user in the session" do
      authenticate

      expect(session.user).to eq(stubbed_user)
    end

    specify "It notifies the observer that authentication succeeded" do
      authenticate

      expect(observer.spy_authentication_succeeded).to be(true)
    end
  end
end
