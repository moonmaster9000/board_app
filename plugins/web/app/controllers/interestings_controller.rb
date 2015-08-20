class InterestingsController < ApplicationController
  def new
    @interesting = Interesting.new
    @errors = {}
  end

  def create
    use_case_factory.create_interesting(
      whiteboard_id: params[:whiteboard_id],
      interesting_repo: interesting_repo,
      attributes: params[:interesting].symbolize_keys,
      observer: self,
      session: app_session,
    ).execute
  end

  def interesting_created(interesting)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end

  def validation_failed(errors)
    @errors = errors
    @interesting = Interesting.new(params[:interesting])
    render action: :new
  end
end

class Interesting
  include ActiveModel::Model
  include Virtus.model

  attribute :title, String
  attribute :description, String
  attribute :date, Date
end
