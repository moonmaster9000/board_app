Board::UseCases::PresentStandupUseCase.add_standup_item_collector -> (repo_factory:, standup_use_case:, team_id: ) {
  standup_use_case.add_items(:new_faces, repo_factory.new_face_repo.all_by_team_id(team_id))
}
