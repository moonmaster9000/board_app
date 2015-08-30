class StandupEmailConfigsController < ApplicationController
  def new
    @validation_errors = []
  end

  def create
    use_case_factory.create_standup_email_config(
      whiteboard_id: params[:whiteboard_id],
      repo_factory: repo_factory,
      attributes: params[:standup_email_config],
      observer: self,
      session: app_session,
    ).execute
  end

  def validation_failed(validation_errors)
    @validation_errors = validation_errors
    render action: :new
  end

  def standup_email_config_created(config)
    flash[:notice] = t('standup_email_configs.create_success_flash_message')
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
