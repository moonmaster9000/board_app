Board::UseCases::PresentStandupUseCase::PRESENT_ITEM_USE_CASES << -> (repo_factory:, observer:, team_id: ) {
  observer.present_items(:helps, repo_factory.help_repo.all_by_team_id(team_id))
}
