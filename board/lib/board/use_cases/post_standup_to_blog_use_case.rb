require "board"
require "board/entities/post"

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
        if post_already_exists?
          tell_observer_already_posted
        elsif invalid_post?
          send_errors_to_observer
        else
          post_standup
        end
      end

      private

      def post_standup
        Board::UseCaseFactory.new.present_standup(
          whiteboard_id: @whiteboard_id,
          observer: PostStandupToBlogObserver.new(blog_client: @blog_client, post_repo: post_repo, post: post),
          date: @standup_date,
          repo_factory: @repo_factory,
        ).execute
      end

      class PostStandupToBlogObserver
        def initialize(blog_client:, post_repo:, post:)
          @blog_client = blog_client
          @post_repo = post_repo
          @post = post
        end

        def standup_presented(standup)
          @blog_client.post(title: @title, standup: standup)
          @post_repo.save(@post)
        end
      end

      def tell_observer_already_posted
        @observer.standup_already_posted
      end

      def send_errors_to_observer
        @observer.validation_failed(post.validation_errors)
      end

      def post_already_exists?
        post_repo.find_by_whiteboard_id_and_standup_date(@whiteboard_id, @standup_date)
      end

      def invalid_post?
        !post.valid?
      end

      def post_repo
        @post_repo ||= @repo_factory.post_repo
      end

      def post
        @post ||= Entities::Post.new(whiteboard_id: @whiteboard_id, standup_date: @standup_date, title: @title)
      end
    end
  end
end
