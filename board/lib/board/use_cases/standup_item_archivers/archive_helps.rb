archive_helps = -> (repo_factory:, team_id:, date:) do
  help_repo = repo_factory.help_repo

  help_repo.unarchived_by_team_id_on_or_before_date(team_id, date).each do |help|
    help.archive!
    help_repo.save(help)
  end
end

Board::UseCases::ArchiveStandupUseCase.add_archiver(archive_helps)
