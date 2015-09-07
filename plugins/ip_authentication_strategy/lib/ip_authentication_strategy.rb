class IpAuthenticationStrategy
  def initialize(whitelist:, user_ip:)
    @whitelist = whitelist
    @user_ip = user_ip
  end

  def execute(observer:)
    if @whitelist.include?(@user_ip)
      observer.authentication_succeeded
    else
      observer.authentication_failed
    end
  end
end
