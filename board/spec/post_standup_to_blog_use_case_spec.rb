require "support/doubles/spy_validations"
require "board"
require "support/board_test_dsl"
require "support/common_assertions"

describe "USE CASE: Post Standup To Blog" do
  include BoardTestDSL
  include CommonAssertions

  context "Given a whiteboard exists" do
    before do
      @whiteboard_id = create_whiteboard.id
    end

    context "Given the standup has not already been posted" do
      context "Given a valid title" do
        let(:title) { valid_title }

        specify "Then the use case will send the standup to the blog client for posting" do
          post_standup(title: title, whiteboard_id: @whiteboard_id, standup_date: standup_date, blog_client: blog_client, observer: post_standup_observer)

          expect(blog_client.posted?).to be(true)
        end

        specify "Then the use case will notify the observer of success" do
          post_standup(title: title, whiteboard_id: @whiteboard_id, standup_date: standup_date, blog_client: blog_client, observer: post_standup_observer)

          expect(post_standup_observer.spy_post_succeeded).to be(true)
        end
      end

      context "Given an empty title" do
        let(:title) { "" }

        specify "Then the use case reports validation errors" do
          post_standup(title: title, whiteboard_id: @whiteboard_id, standup_date: standup_date, blog_client: blog_client, observer: post_standup_observer)

          assert_observer_got_one_error(post_standup_observer, :title, :required)
        end
      end

      context "Given a nil title" do
        let(:title) { nil }

        specify "Then the use case reports validation errors" do
          post_standup(title: title, whiteboard_id: @whiteboard_id, standup_date: standup_date, blog_client: blog_client, observer: post_standup_observer)

          assert_observer_got_one_error(post_standup_observer, :title, :required)
        end
      end
    end

    context "Given the standup has already been posted" do
      before do
        post_standup(
          title: valid_title,
          standup_date: standup_date,
          blog_client: blog_client,
          observer: post_standup_observer,
          whiteboard_id: @whiteboard_id,
        )
      end

      specify "Then the use case should fail" do
        post_standup(title: valid_title, whiteboard_id: @whiteboard_id, standup_date: standup_date, blog_client: blog_client, observer: post_standup_observer)

        expect(post_standup_observer.spy_standup_already_posted).to be(true)
      end
    end
  end

  let(:standup_date) { Date.today }
  let(:blog_client) { BlogClientSpy.new }
  let(:post_standup_observer) { PostStandupObserverSpy.new }
  let(:valid_title) { "valid title" }

  def post_standup(title:, standup_date:, blog_client:, observer:, whiteboard_id:)
    Board::UseCaseFactory.new.post_standup_to_blog(
      title: title,
      standup_date: standup_date,
      blog_client: blog_client,
      observer: observer,
      whiteboard_id: whiteboard_id,
      repo_factory: repo_factory,
    ).execute
  end

  class BlogClientSpy
    def post(*)
      @posted = true
    end

    def posted?
      !!@posted
    end
  end

  class PostStandupObserverSpy
    include SpyValidations

    def standup_already_posted
      @spy_standup_already_posted = true
    end
    attr_reader :spy_standup_already_posted

    def post_succeeded
      @spy_post_succeeded = true
    end
    attr_reader :spy_post_succeeded
  end
end
