class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def team_repo
    Rails.application.config.team_repo
  end

  def new_face_repo
    Rails.application.config.new_face_repo
  end
end
