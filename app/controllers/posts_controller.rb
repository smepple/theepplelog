class PostsController < ApplicationController
  before_filter :require_login_from_http_basic, only: ['new', 'admin', 'edit']
  before_filter :find_post, only: ['edit', 'update']

  def index
    @posts = Post.where(draft: false).all
  end

  def admin
    @drafts = @posts = Post.where(draft: true).all
    @published = @posts = Post.where(draft: false).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params[:post])

    if @post.save
      redirect_to root_path
    else
      flash = "Oops"
      render 'new'
    end
  end

  def show
    @post = Post.find_by_slug(params[:slug])
  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to admin_path
    else
      flash = "Oops"
      render 'edit'
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
