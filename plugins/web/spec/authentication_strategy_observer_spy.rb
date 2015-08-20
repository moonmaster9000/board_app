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
