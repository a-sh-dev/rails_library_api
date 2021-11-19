Rails.application.routes.draw do
  get '/categories', to: 'categories#index', as: 'categories'
  # blog_posts
  get '/posts', to: 'blog_posts#index', as: 'posts'
  post '/posts', to: 'blog_posts#create'
  get '/posts/:id', to: 'blog_posts#show', as: 'post'
  put '/posts/:id', to: 'blog_posts#update'
  patch '/posts/:id', to: 'blog_posts#update'
  delete '/posts/:id', to: 'blog_posts#destroy'
  # users autho
  post '/auth/login', to: 'auth#login', as: 'login'
  post '/auth/register', to: 'auth#register', as: 'register'
end
