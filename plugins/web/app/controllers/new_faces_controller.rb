class NewFacesController < ApplicationController
  before_filter :blank_out_errors

  def new
    @errors = {}
    @new_face = NewFace.new
  end

  def create
    use_case_factory.create_new_face(
      observer: CreateObserver.new(self),
      session: app_session,
      new_face_repo: new_face_repo,
      whiteboard_id: params[:whiteboard_id],
      attributes: NewFace.new(params[:new_face]).attributes,
    ).execute
  end

  def edit
    use_case_factory.read_new_face(
      observer: EditObserver.new(self),
      session: app_session,
      repo_factory: repo_factory,
      new_face_id: params[:id],
    ).execute
  end

  def update
    use_case_factory.update_new_face(
      observer: UpdateObserver.new(self),
      session: app_session,
      repo_factory: repo_factory,
      new_face_id: params[:id],
      attributes: NewFace.new(params[:new_face]).attributes,
    ).execute
  end

  def destroy
    use_case_factory.delete_new_face(
      observer: DeleteNewFaceObserver.new(self),
      session: app_session,
      repo_factory: repo_factory,
      new_face_id: params[:id],
    ).execute
  end

  class DeleteNewFaceObserver < DeleteObserver
    def delete_success_flash_message
      t('new_faces.delete_success_flash_message')
    end
  end

  class CreateObserver < SimpleDelegator
    def new_face_created(new_face)
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_new_face(params[:new_face])

      render action: :new
    end
  end

  class UpdateObserver < SimpleDelegator
    def new_face_updated(*)
      flash[:notice] = t('new_faces.update_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def validation_failed(errors)
      set_errors(errors)
      set_new_face(params[:new_face])

      render action: :edit
    end
  end

  class EditObserver < SimpleDelegator
    def new_face_read(new_face)
      set_new_face(new_face.attributes)
    end
  end

  def set_errors(errors)
    @errors = errors
  end

  def set_new_face(attributes)
    @new_face = NewFace.new(attributes)
  end

  private
  def blank_out_errors
    @errors = {}
  end
end

class NewFace
  include ActiveModel::Model
  include Virtus.model

  attribute :name, String
  attribute :author, String
  attribute :date, Date
  attribute :private, Boolean
end
