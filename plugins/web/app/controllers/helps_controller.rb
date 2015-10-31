require "delegate"

class HelpsController < ApplicationController
  def new
    blank_out_errors
    set_help(Help.new)
  end

  def edit
    use_case_factory.read_help(
      observer: EditObserver.new(self),
      session: app_session,
      help_id: params[:id],
      repo_factory: repo_factory,
    ).execute
  end

  def update
    use_case_factory.update_help(
      observer: UpdateObserver.new(self),
      session: app_session,
      help_id: params[:id],
      attributes: Help.new(params[:help]).attributes,
      repo_factory: repo_factory,
    ).execute
  end

  def create
    use_case_factory.create_help(
      observer: CreateObserver.new(self),
      session: app_session,
      whiteboard_id: params[:whiteboard_id],
      help_repo: help_repo,
      attributes: Help.new(params[:help]).attributes,
    ).execute
  end

  def destroy
    use_case_factory.delete_help(
      observer: DeleteHelpObserver.new(self),
      session: app_session,
      help_id: params[:id],
      repo_factory: repo_factory,
    ).execute
  end

  class DeleteHelpObserver < DeleteObserver
    def delete_success_flash_message
      t('helps.delete_success_flash_message')
    end
  end

  def set_help(help)
    @help = help
  end

  def set_errors(errors)
    @errors = errors
  end

  def blank_out_errors
    @errors = {}
  end

  class CreateObserver < SimpleDelegator
    def validation_failed(errors)
      set_errors(errors)
      set_help(Help.new(params[:help]))

      render action: :new
    end

    def help_created(help)
      flash[:notice] = t('helps.create_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end
  end

  class UpdateObserver < SimpleDelegator
    def help_updated(help)
      flash[:notice] = t('helps.update_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end


    def validation_failed(errors)
      set_errors(errors)
      set_help(Help.new(params[:help]))

      render action: :edit
    end
  end

  class EditObserver < SimpleDelegator
    def help_read(help)
      set_help(Help.new(help.attributes))
      blank_out_errors

      render action: :edit
    end
  end
end

class Help
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :author, String
  attribute :date, Date
  attribute :private, Boolean
end
