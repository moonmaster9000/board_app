require "board"

module Board
  module UseCases
    class PostStandupToBlogUseCase
      def initialize(title:, repo_factory:, whiteboard_id:, standup_date:, blog_client: , observer:)
        @title = title
        @standup_date = standup_date
        @blog_client = blog_client
        @observer = observer
        @whiteboard_id = whiteboard_id
        @repo_factory = repo_factory
      end

      def execute
        if @repo_factory.post_repo.find_by_whiteboard_id_and_standup_date(@whiteboard_id, @standup_date)
          @observer.standup_already_posted
        else
          Board::UseCaseFactory.new.present_standup(
            whiteboard_id: @whiteboard_id,
            observer: self,
            date: @standup_date,
            repo_factory: @repo_factory,
          ).execute
        end
      end

      def standup_presented(standup)
        @blog_client.post(title: @title, standup: standup)
      end
    end
  end
end
