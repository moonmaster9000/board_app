class EventsController < ApplicationController
  def new
    @errors = {}
    @event = Event.new
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

  def validation_failed(errors)
    @errors = errors
    @event = Event.new(params[:event])
    render action: :new
  end
end

class Event
  attr_accessor :title, :description, :date
  include ActiveModel::Model
end
