class HelpsController < ApplicationController
  def new
    @whiteboard_id = params[:whiteboard_id]
  end

  def create
    use_case_factory.create_help(
      observer: self,
      session: app_session,
      whiteboard_id: params[:whiteboard_id],
      help_repo: help_repo,
      attributes: params[:help],
    ).execute
  end

  def help_created(help)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
