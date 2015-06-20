class StandupsController < ApplicationController

  def show
    Board.present_standup(
      whiteboard_id: params[:id],
      observer: self,
      date: Date.parse(params[:date]),
      repo_factory: repo_factory,
    ).execute
  end

  def standup_presented(standup)
    @standup = standup
  end
end
