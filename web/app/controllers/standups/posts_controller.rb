module Standups
  class PostsController < ApplicationController
    def create
      use_case_factory.post_standup_to_blog(
        title: "Fake Title",
        repo_factory: repo_factory,
        whiteboard_id: params[:whiteboard_id],
        standup_date: params[:standup_id],
        blog_client: WordpressClient.new(username: ENV['WORDPRESS_USERNAME'], password: ENV['WORDPRESS_PASSWORD'], host: ENV['WORDPRESS_HOST']),
        observer: self,
        session: app_session,
      ).execute
    end
  end
end
