class PostsController < ApplicationController
  before_filter :require_login_from_http_basic, only: ['new']

  def index
    @posts = Post.where(draft: true).all
  end

  def new
  end
end
