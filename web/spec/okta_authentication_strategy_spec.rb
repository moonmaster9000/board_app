require "web/okta_authentication_strategy"
require "authentication_strategy_observer_spy"

describe Web::OktaAuthenticationStrategy do
  context "When Okta authenticates a user with a pivotal.io email address" do
    let(:auth_hash) do
      {"info" => {"email" => "pivot@pivotal.io"}}
    end

    specify "then the auth strategy succeeds" do
      Web::OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_succeeded).to be(true)
    end
  end

  context "When Okta authenticates a user with a non-pivotal.io email address" do
    let(:auth_hash) do
      {"info" => {"email" => "hacker@hacker.io"}}
    end

    specify "then the auth strategy fails" do
      Web::OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  context "When Okta doesn't return an email address for the user" do
    let(:auth_hash) do
      {"info" => {}}
    end

    specify "then the auth strategy fails" do
      Web::OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  context "When Okta doesn't return any info for the user" do
    let(:auth_hash) do
      {}
    end

    specify "then the auth strategy fails" do
      Web::OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  let(:observer) { AuthenticationStrategyObserverSpy.new }
end
