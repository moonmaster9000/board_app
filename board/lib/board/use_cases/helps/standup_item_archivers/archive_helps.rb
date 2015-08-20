archive_helps = -> (repo_factory:, whiteboard_id:, date:) do
  help_repo = repo_factory.help_repo

  help_repo.unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date).each do |help|
    help.archive!
    help_repo.save(help)
  end
end

Board::UseCases::ArchiveStandupUseCase.add_archiver(archive_helps)
