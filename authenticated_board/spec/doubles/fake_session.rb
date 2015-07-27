class FakeSession
  def log_in
    @logged_in = true
  end

  def logged_in?
    !!@logged_in
  end
end
