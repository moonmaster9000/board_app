Board::UseCases::PresentStandupUseCase.add_standup_item_collector(
  -> (repo_factory:, standup_use_case:, whiteboard_id:, date:) {
    standup_use_case.add_items(
      :helps,
      repo_factory.help_repo.unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date)
    )
  }
)
