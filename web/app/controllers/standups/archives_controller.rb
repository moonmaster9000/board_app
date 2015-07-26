module Standups
  class ArchivesController < ApplicationController
    def create
      use_case_factory.archive_standup(
        whiteboard_id: params[:whiteboard_id],
        repo_factory: repo_factory,
        date: params[:standup_id],
        observer: self,
      ).execute
    end

    def standup_archived
      redirect_to whiteboard_path(params[:whiteboard_id])
    end
  end
end
