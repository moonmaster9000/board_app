module Standups
  class PresentStandupItemsController < ApplicationController
    def index
      Board.present_standup(
        whiteboard_id: params[:whiteboard_id],
        observer: self,
        date: Date.parse(params[:standup_id]),
        repo_factory: repo_factory,
      ).execute
    end

    def standup_presented(standup)
      @standup = standup
    end
  end
end
