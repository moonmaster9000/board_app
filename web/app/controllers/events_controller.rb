class EventsController < ApplicationController
  def new
    @whiteboard_id = params[:whiteboard_id]
  end

  def create
    use_case_factory.create_event(
      observer: self,
      session: app_session,
      whiteboard_id: params[:whiteboard_id],
      event_repo: event_repo,
      attributes: params[:event].symbolize_keys,
    ).execute
  end

  def event_created(event)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
