class HelpsController < ApplicationController
  def new
    @errors = {}
    @help = Help.new
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

  def validation_failed(errors)
    @errors = errors
    @help = Help.new(params[:help])
    render action: :new
  end

  def help_created(help)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end

class Help
  include ActiveModel::Model
  include Virtus.model

  attribute :description, String
  attribute :date, Date
end
