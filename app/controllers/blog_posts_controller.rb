class BlogPostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]
  before_action :authenticate, only: %i[create update destroy]

  def index
    posts = BlogPost.all.includes(:author, :category)
    render json: posts, include: {
      author: { only: :username }, category: { only: :name }
    }, status: 200
  end

  def show
    render json: @post, include: {
      author: { only: :username }, category: { only: :name }
    }, status: 200
  end

  def create
    post = current_user.blog_posts.create(post_params)
    render_post(post)
  end

  def update
    @post.update(post_params)
    render_post(@post)
  end

  def destroy
    attributes = @post.attributes
    @post.destroy
    render json: attributes, status: 202
  end

  private

  def set_post
    @post = BlogPost.find(params[:id])
  rescue StandardError
    render json: { error: 'Unable to find post' }, status: 404
  end

  def post_params
    params.require(:blog_post).permit(:title, :content, :category_id, :user_id)
  end

  def authorize
    render json: { error: "You don't have permission to do that" }, status: 401 unless current_user.id == @post.user_id
  end

  def render_post(post)
    if post.errors.none?
      render json: post, include: {
        author: { only: :username }, category: { only: :name }
      }, status: 201
    else
      render json: { errors: post.errors.full_messages }, status: 422
    end
  end
end
