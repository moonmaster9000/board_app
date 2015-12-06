module Standups
  class PostsController < ApplicationController
    def new
      @validation_errors = []
    end

    def create
      use_case_factory.post_standup_to_blog(
        title: params[:post][:title],
        repo_factory: repo_factory,
        whiteboard_id: params[:whiteboard_id],
        standup_date: params[:standup_id],
        blog_client: WordpressClient.new(username: ENV['WORDPRESS_USERNAME'], password: ENV['WORDPRESS_PASSWORD'], host: ENV['WORDPRESS_HOST']),
        observer: self,
        session: app_session,
      ).execute
    end

    def validation_failed(errors)
      @validation_errors = errors
      render :new
    end

    def post_succeeded
      flash[:notice] = t('posts.post_success_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end

    def standup_already_posted
      flash[:notice] = t('posts.standup_already_posted_flash_message')
      redirect_to whiteboard_path(params[:whiteboard_id])
    end
  end
end
