require "web/ip_authentication_strategy"
require "authentication_strategy_observer_spy"

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
end
