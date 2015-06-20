class InterestingsController < ApplicationController
  def new
    @whiteboard_id = params[:whiteboard_id]
  end

  def create
    Board.create_interesting(
      whiteboard_id: params[:whiteboard_id],
      interesting_repo: interesting_repo,
      attributes: params[:interesting].symbolize_keys,
      observer: self,
    ).execute
  end

  def interesting_created(interesting)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end

  def validation_failed(validation_errors)
    raise validation_errors.inspect
  end
end
