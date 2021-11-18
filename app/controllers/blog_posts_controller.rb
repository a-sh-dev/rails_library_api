class BlogPostsController < ApplicationController

  def index
    posts = BlogPost.all.includes(:author, :category)
    render json: posts, include: { 
      author: { only: :username }, category: { only: :name } 
    }, status: 200
  end
  
end
