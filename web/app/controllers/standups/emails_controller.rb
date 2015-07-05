module Standups
  class EmailsController < ApplicationController
    def create
      Board.email_standup_use_case(
        email_client: self,
        observer: self,
        standup_email_formatter: MarkdownStandupEmailFormatter.new,
        whiteboard_id: params[:whiteboard_id],
        date: params[:standup_id],
        repo_factory: repo_factory,
      ).execute
    end

    def send_email(*)
    end

    def email_sent(email)
      @email = email
    end
  end
end
