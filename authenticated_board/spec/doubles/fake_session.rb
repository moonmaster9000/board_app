class FakeSession
  attr_reader :logged_in_user

  def log_in(user)
    @logged_in_user = user
  end

  def logged_in?
    !!@logged_in_user
  end
end
