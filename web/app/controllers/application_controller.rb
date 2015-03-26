class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def team_repo
    repo_factory.team_repo
  end

  def new_face_repo
    repo_factory.new_face_repo
  end

  def repo_factory
    Rails.application.config.repo_factory
  end
end
