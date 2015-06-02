collect_events_for_whiteboard = -> (repo_factory:, whiteboard_id:, whiteboard_items:) do
  unarchived_events = repo_factory.event_repo.unarchived_by_whiteboard_id(whiteboard_id)
  whiteboard_items.add_items(:events, unarchived_events)
end

Board::UseCases::PresentWhiteboardItemsUseCase.add_collector(collect_events_for_whiteboard)
