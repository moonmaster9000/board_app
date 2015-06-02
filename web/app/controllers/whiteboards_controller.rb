class WhiteboardsController < ApplicationController
  def new

  end

  def show
    Board.present_whiteboard(
      observer: self,
      whiteboard_id: params[:id],
      whiteboard_repo: whiteboard_repo,
    ).execute

    Board.present_whiteboard_items(
      observer: self,
      whiteboard_id: params[:id],
      repo_factory: repo_factory,
    ).execute
  end

  def create
    Board.create_whiteboard(
      observer: self,
      attributes: params[:whiteboard].symbolize_keys,
      whiteboard_repo: whiteboard_repo,
    ).execute
  end

  def whiteboard_created(whiteboard)
    redirect_to whiteboard_path(whiteboard.id)
  end

  def whiteboard_presented(whiteboard)
    @whiteboard = whiteboard
  end

  def whiteboard_items_presented(items)
    @whiteboard_items = items
  end
end
