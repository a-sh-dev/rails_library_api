Rails.application.routes.draw do
  get "/categories", to: "categories#index", as: "categories"
  get "/posts", to: "blog_posts#index", as: "posts"
  post "/posts", to: "blog_posts#create"
  get "/posts/:id", to: "blog_posts#show", as: "post"
end
