class NewFacesController < ApplicationController
  def new
    @whiteboard_id = params[:whiteboard_id]
  end

  def create
    use_case_factory.create_new_face(
      observer: self,
      new_face_repo: new_face_repo,
      whiteboard_id: params[:whiteboard_id],
      attributes: params[:new_face],
    ).execute
  end

  def new_face_created(new_face)
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
