class PostsController < ApplicationController
  def index
    @posts = Post
      .all
      .order('created_at desc')
      .limit(100)
  end

  def top
    # TODO: Only show the top posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def upvote
    post = Post.find(params[:id])
    post.upvote!

    redirect_to post
  end
end
