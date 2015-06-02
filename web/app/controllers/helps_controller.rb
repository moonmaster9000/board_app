class HelpsController < ApplicationController
  def new
    @whiteboard_id = params[:whiteboard_id]
  end

  def create
   Board.create_help(
            observer: self,
            whiteboard_id: params[:whiteboard_id],
            help_repo: help_repo,
            attributes: help_params
   ).execute
  end

  def help_created(help)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end

  private

  def help_params
    params.require(:help).permit(:description, :date)
  end
end
