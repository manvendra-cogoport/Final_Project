Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  post "/category/post", to: "categories#create"

  get "categories/all", to: "categories#all"

  get "category/:id", to: "categories#index"

  get "articles/page/:page", to: "articles#read_all"

  get "article/:id", to: "articles#read"

  post "articles/post", to: "articles#create"

  put "article/update/:id", to: "articles#update"

  delete "article/delete/:id", to: "articles#delete"

  get "articles/author/:username",  to: "articles#byusername"

  get "articles/search/:searchtext", to: "articles#partialsearch"

  get "journals", to: "journals#index"


  resources :users, param: :_username
  
  post '/auth/login', to: 'authentication#login'

  get '/*a', to: 'application#not_found'

  get '/users', to: "users#index"

  post '/users/sign_up', to: 'users#create'

  get '/users/:username', to: 'user#show'

  put '/users/:username', to: 'user#update'

  delete '/users/:username', to: 'user#destroy'

  post "articles/likes/:article_id", to: "likes#like"

  post "articles/comments/:article_id", to: "comments#comment"

  get "articles/mostliked", to: "likes#mostliked"

  get "articles/mostcommented", to: "comments#mostcommented"


end
