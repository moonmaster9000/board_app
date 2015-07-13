class StandupEmailConfigsController < ApplicationController
  def new
    @validation_errors = []
  end

  def create
    Board.create_standup_email_config(
      whiteboard_id: params[:whiteboard_id],
      repo_factory: repo_factory,
      attributes: params[:standup_email_config],
      observer: self,
    ).execute
  end

  def validation_failed(validation_errors)
    @validation_errors = validation_errors
    render action: "new"
  end

  def standup_email_config_created(config)
    flash[:notice] = "Standup Email Config created!"
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
