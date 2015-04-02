class HelpsController < ApplicationController
  def new
    @team_id = params[:team_id]
  end

  def create
   Board.create_help(
            observer: self,
            team_id: params[:team_id],
            help_repo: help_repo,
            attributes: help_params
   ).execute
  end

  def help_created(help)
    redirect_to team_path(params[:team_id])
  end

  private

  def help_params
    params.require(:help).permit(:description, :date)
  end
end