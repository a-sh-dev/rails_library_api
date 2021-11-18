Rails.application.routes.draw do
  get "/categories", to: "categories#index", as: "categories"
  get "/posts", to: "blog_posts#index", as: "posts"
end
