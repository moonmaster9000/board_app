module Standups
  class EmailsController < ApplicationController
    def create
      Board.email_standup_use_case(
        email_client: email_client,
        observer: self,
        standup_email_formatter: MarkdownStandupEmailFormatter.new,
        whiteboard_id: params[:whiteboard_id],
        date: params[:standup_id],
        repo_factory: repo_factory,
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
