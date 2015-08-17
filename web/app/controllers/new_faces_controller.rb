class NewFacesController < ApplicationController
  before_filter :set_new_face_attributes

  def new
    @errors = {}
  end

  def create
    use_case_factory.create_new_face(
      observer: self,
      session: app_session,
      new_face_repo: new_face_repo,
      whiteboard_id: params[:whiteboard_id],
      attributes: params[:new_face],
    ).execute
  end

  def new_face_created(new_face)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end

  def validation_failed(errors)
    @errors = errors
    render action: :new
  end

  private
  def set_new_face_attributes
    @new_face_attributes = params[:new_face] || {}
  end
end
