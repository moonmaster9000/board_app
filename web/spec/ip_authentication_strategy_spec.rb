require "web/ip_authentication_strategy"

describe Web::IpAuthenticationStrategy do
  context "given a user accesses the site with a whitelisted ip" do
    let(:user_ip) { whitelist.first }

    specify "then the authentication strategy succeeds" do
      Web::IpAuthenticationStrategy.new(
        whitelist: whitelist,
        user_ip: user_ip,
      ).execute(observer: observer)

      expect(observer.spy_authentication_succeeded).to be(true)
    end
  end

  context "given a user accesses the site with a non-whitelisted ip" do
    let(:user_ip) { rand }

    specify "then the authentication strategy fails" do
      Web::IpAuthenticationStrategy.new(
        whitelist: whitelist,
        user_ip: user_ip,
      ).execute(observer: observer)

      expect(observer.spy_authentication_failed).to be(true)
    end
  end

  let(:whitelist) { [1,2,3] }
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
