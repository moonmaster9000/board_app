module Standups
  class EmailsController < ApplicationController
    def new

    end

    def create
      use_case_factory.email_standup(
        email_client: email_client,
        observer: self,
        session: app_session,
        standup_email_formatter: MarkdownStandupEmailFormatter.new,
        whiteboard_id: params[:whiteboard_id],
        date: params[:standup_id],
        repo_factory: repo_factory,
        attributes: params[:email].symbolize_keys,
      ).execute
    end

    def email_sent(email)
      @email = email
    end

    def email_not_configured
      redirect_to new_whiteboard_standup_email_config_path(params[:whiteboard_id])
    end
  end
end
