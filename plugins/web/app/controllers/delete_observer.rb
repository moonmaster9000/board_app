class DeleteObserver < SimpleDelegator
  def delete_succeeded
    flash[:notice] = delete_success_flash_message
    redirect_to whiteboard_path(params[:whiteboard_id])
  end
end
