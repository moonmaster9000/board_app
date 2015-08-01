class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  def authentication_succeeded(*)
  end

  def already_authenticated(*)
  end

  def authentication_failed
    raise "authentication failed :-("
  end

  private
  def authenticate
    require "web/ip_authentication_strategy"

    use_case_factory.authenticate(
      observer: self,
      session: app_session,
      authentication_strategy: Web::IpAuthenticationStrategy.new(
        whitelist: Rails.application.config.ip_authentication_whitelist,
        user_ip: request.remote_ip,
      ),
    ).execute
  end

  def app_session
    require "web/cookie_session"
    @app_session ||= Web::CookieSession.new(session)
  end

  def whiteboard_repo
    repo_factory.whiteboard_repo
  end

  def use_case_factory
    Rails.application.config.use_case_factory
  end

  def email_client
    @email_client = EmailClient.new(Rails.configuration.email_client_delivery_method_config)
  end

  def new_face_repo
    repo_factory.new_face_repo
  end

  def event_repo
    repo_factory.event_repo
  end

  def help_repo
    repo_factory.help_repo
  end

  def interesting_repo
    repo_factory.interesting_repo
  end

  def repo_factory
    Rails.application.config.repo_factory
  end
end
