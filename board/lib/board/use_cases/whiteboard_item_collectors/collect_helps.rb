collect_helps_for_whiteboard = -> (repo_factory:, team_id:, whiteboard_items:) do
  unarchived_helps = repo_factory.help_repo.unarchived_by_team_id(team_id)
  whiteboard_items.add_items(:helps, unarchived_helps)
end

Board::UseCases::PresentWhiteboardItemsUseCase.add_collector(collect_helps_for_whiteboard)
