collect_new_faces_for_whiteboard = -> (repo_factory:, team_id:, whiteboard_items:) do
  unarchived_new_faces = repo_factory.new_face_repo.unarchived_by_team_id(team_id)
  whiteboard_items.add_items(:new_faces, unarchived_new_faces)
end

Board::UseCases::PresentWhiteboardUseCase.add_collector(collect_new_faces_for_whiteboard)
