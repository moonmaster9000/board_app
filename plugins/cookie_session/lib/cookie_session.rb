class CookieSession
  def initialize(cookie={})
    @cookie = cookie
  end

  def log_in
    @cookie[:logged_in] = true
  end

  def logged_in?
    !!@cookie[:logged_in]
  end
end
