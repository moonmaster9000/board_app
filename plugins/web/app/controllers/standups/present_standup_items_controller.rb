module Standups
  class PresentStandupItemsController < ApplicationController
    def index
      use_case_factory.present_standup(
        whiteboard_id: params[:whiteboard_id],
        observer: self,
        session: app_session,
        date: Date.parse(params[:standup_id]),
        repo_factory: repo_factory,
      ).execute
    end

    def standup_presented(standup)
      @standup = standup
    end
  end
end
