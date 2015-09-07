require "okta_authentication_strategy"

describe OktaAuthenticationStrategy do
  context "When Okta authenticates a user with a pivotal.io email address" do
    let(:auth_hash) do
      {"info" => {"email" => "pivot@pivotal.io"}}
    end

    specify "then the auth strategy succeeds" do
      OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_succeeded).to be(true)
    end
  end

  context "When Okta authenticates a user with a non-pivotal.io email address" do
    let(:auth_hash) do
      {"info" => {"email" => "hacker@hacker.io"}}
    end

    specify "then the auth strategy fails" do
      OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  context "When Okta doesn't return an email address for the user" do
    let(:auth_hash) do
      {"info" => {}}
    end

    specify "then the auth strategy fails" do
      OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  context "When Okta doesn't return any info for the user" do
    let(:auth_hash) do
      {}
    end

    specify "then the auth strategy fails" do
      OktaAuthenticationStrategy.new(auth_hash: auth_hash).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  let(:observer) { AuthenticationStrategyObserverSpy.new }

  class AuthenticationStrategyObserverSpy
    def authentication_succeeded
      @spy_authentication_succeeded = true
    end
    attr_reader :spy_authentication_succeeded

    def authentication_failed
      @spy_authentication_failed = true
    end
    attr_reader :spy_authentication_failed
  end
end

