module Standups
  class StandupsController < ApplicationController
    def show
      redirect_to whiteboard_standup_new_faces_path(params[:whiteboard_id], params[:id])
    end
  end
end

