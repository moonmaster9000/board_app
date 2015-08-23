class EventsController < ApplicationController
  def new
    @errors = {}
    @event = Event.new
  end

  def edit
    use_case_factory.read_event(
      observer: self,
      session: app_session,
      event_id: params[:id],
      repo_factory: repo_factory,
    ).execute
  end

  def event_read(event)
    @event = Event.new(event.attributes)
    @errors = {}

    render action: :edit
  end

  def update
    use_case_factory.update_event(
      event_id: params[:id],
      attributes: params[:event].symbolize_keys,
      repo_factory: repo_factory,
      observer: self,
      session: app_session,
    ).execute
  end

  def event_updated(*)
    flash[:notice] = "Event updated"
    redirect_to whiteboard_path(params[:whiteboard_id])
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
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :date, Date
end
