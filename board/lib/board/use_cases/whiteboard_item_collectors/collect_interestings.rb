collect_interestings_for_whiteboard = -> (repo_factory:, team_id:, whiteboard_items:) do
  unarchived_interestings = repo_factory.interesting_repo.unarchived_by_team_id(team_id)
  whiteboard_items.add_items(:interestings, unarchived_interestings)
end

Board::UseCases::PresentWhiteboardItemsUseCase.add_collector(collect_interestings_for_whiteboard)
