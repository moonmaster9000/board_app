class EventsController < ApplicationController
  def new
    blank_out_errors
    set_event(Event.new)
  end

  def edit
    use_case_factory.read_event(
      observer: EditObserver.new(self),
      session: app_session,
      event_id: params[:id],
      repo_factory: repo_factory,
    ).execute
  end

  def update
    use_case_factory.update_event(
      event_id: params[:id],
      attributes: params[:event].symbolize_keys,
      repo_factory: repo_factory,
      observer: UpdateObserver.new(self),
      session: app_session,
    ).execute
  end

  def create
    use_case_factory.create_event(
      observer: CreateObserver.new(self),
      session: app_session,
      whiteboard_id: params[:whiteboard_id],
      event_repo: event_repo,
      attributes: params[:event].symbolize_keys,
    ).execute
  end

  def blank_out_errors
    @errors = {}
  end

  def set_event(e)
    @event = e
  end

  def set_errors(errors)
    @errors = errors
  end

  class EditObserver < SimpleDelegator
    def event_read(event)
      set_event(Event.new(event.attributes))
      blank_out_errors

      render action: :edit
    end
  end

  class CreateObserver < SimpleDelegator
    def event_created(event)
      flash[:notice] = t('events.create_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_event(Event.new(params[:event]))

      render action: :new
    end
  end

  class UpdateObserver < SimpleDelegator
    def event_updated(*)
      flash[:notice] = t('events.update_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_event(Event.new(params[:event]))

      render action: :edit
    end
  end
end

class Event
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :date, Date
end
