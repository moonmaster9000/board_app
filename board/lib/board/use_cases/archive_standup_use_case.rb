module Board
  module UseCases
    class ArchiveStandupUseCase
      class << self
        def archivers
          @archivers ||= []
        end

        def add_archiver(lambda)
          archivers << lambda
        end
      end

      def initialize(team_id:, observer:, date:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @team_id = team_id
        @date = date
      end

      def execute
        self.class.archivers.each do |archiver|
          archiver.call(repo_factory: @repo_factory, team_id: @team_id, date: @date)
        end
      end
    end
  end
end

Dir[File.join(__dir__, "standup_item_archivers", "**", "*.rb")].each do |archiver|
  require archiver
end
