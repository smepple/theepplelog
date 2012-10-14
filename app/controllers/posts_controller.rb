class PostsController < ApplicationController
  before_filter :authorize, only: ['new', 'admin', 'edit', 'preview']
  before_filter :find_post, only: ['edit', 'update', 'preview']

  def index
    @posts = Post.where(draft: false).paginate(:page => params[:page], :per_page => 10)
  end

  def archive
    @posts_by_month = Post.where(draft: false).all.group_by { |post| post.published_at.strftime("%B %Y") }
    
    if params[:year].present? && params[:month].present?
      @posts_in_month = Post.where('draft = ? AND published_at BETWEEN ? AND ?', 
                                      false, 
                                      "#{params[:year]}-#{params[:month]}-01",
                                      "#{params[:year]}-#{params[:month]}-31").all
    end
  end

  def admin
    @drafts = @posts = Post.where(draft: true).all
    @published = @posts = Post.where(draft: false).all
  end

  def new
    @post = Post.new
  end

  def preview
  end

  def create
    @post = Post.create(params[:post])

    if @post.save
      flash[:success] = "Created!"
      redirect_to admin_path
    else
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
      flash.now[:success] = "Updated!"
      render 'edit'
    else
      render 'edit'
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end
end
