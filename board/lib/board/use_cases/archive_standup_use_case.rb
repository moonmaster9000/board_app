module Board
  module UseCases
    class ArchiveStandupUseCase
      def initialize(team_id:, observer:, date:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @team_id = team_id
        @date = date
      end

      def execute
        new_face_repo = @repo_factory.new_face_repo

        new_face_repo.unarchived_by_team_id_on_or_before_date(@team_id, @date).each do |new_face|
          new_face.archive!
          new_face_repo.save(new_face)
        end
        
        help_repo = @repo_factory.help_repo

        help_repo.unarchived_by_team_id_on_or_before_date(@team_id, @date).each do |help|
          help.archive!
          help_repo.save(help)
        end
      end
    end
  end
end
