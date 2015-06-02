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

      def initialize(whiteboard_id:, observer:, date:, repo_factory:)
        @repo_factory = repo_factory
        @observer = observer
        @whiteboard_id = whiteboard_id
        @date = date
      end

      def execute
        self.class.archivers.each do |archiver|
          archiver.call(repo_factory: @repo_factory, whiteboard_id: @whiteboard_id, date: @date)
        end
      end
    end
  end
end

Dir[File.join(__dir__, "standup_item_archivers", "**", "*.rb")].each do |archiver|
  require archiver
end
