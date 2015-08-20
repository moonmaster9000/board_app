archive_new_faces = ->(repo_factory:, whiteboard_id:, date:) do
  new_face_repo = repo_factory.new_face_repo

  new_face_repo.unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date).each do |new_face|
    new_face.archive!
    new_face_repo.save(new_face)
  end
end

Board::UseCases::ArchiveStandupUseCase.add_archiver(archive_new_faces)
