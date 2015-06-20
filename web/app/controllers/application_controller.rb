class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def whiteboard_repo
    repo_factory.whiteboard_repo
  end

  def new_face_repo
    repo_factory.new_face_repo
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
