class InterestingsController < ApplicationController
  def new
    @interesting = Interesting.new
    @errors = {}
  end

  def edit
    @errors = {}

    use_case_factory.read_interesting(
      repo_factory: repo_factory,
      interesting_id: params[:id],
      observer: EditObserver.new(self),
      session: app_session,
    ).execute
  end

  def update
    use_case_factory.update_interesting(
      repo_factory: repo_factory,
      interesting_id: params[:id],
      attributes: params[:interesting].symbolize_keys,
      session: app_session,
      observer: UpdateObserver.new(self),
    ).execute
  end

  class UpdateObserver < SimpleDelegator
    def interesting_updated(*)
      flash[:notice] = t('interestings.update_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_interesting(Interesting.new(params[:interesting]))

      render action: :edit
    end
  end

  def set_interesting(interesting)
    @interesting = interesting
  end

  class EditObserver < SimpleDelegator
    def interesting_read(interesting)
      set_interesting(Interesting.new(interesting.attributes))
    end
  end

  def create
    use_case_factory.create_interesting(
      whiteboard_id: params[:whiteboard_id],
      interesting_repo: interesting_repo,
      attributes: params[:interesting].symbolize_keys,
      observer: CreateObserver.new(self),
      session: app_session,
    ).execute
  end

  class CreateObserver < SimpleDelegator
    def interesting_created(interesting)
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_interesting(Interesting.new(params[:interesting]))

      render action: :new
    end
  end

  def set_errors(errors)
    @errors = errors
  end
end

class Interesting
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :date, Date
end
