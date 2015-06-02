archive_interestings = -> (repo_factory:, whiteboard_id:, date:) do
  interesting_repo = repo_factory.interesting_repo

  interesting_repo.unarchived_by_whiteboard_id_on_or_before_date(whiteboard_id, date).each do |interesting|
    interesting.archive!
    interesting_repo.save(interesting)
  end
end

Board::UseCases::ArchiveStandupUseCase.add_archiver(archive_interestings)
