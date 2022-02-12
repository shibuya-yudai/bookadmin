Rails.application.routes.draw do
  resources :chapters
  patch '/chapters', to: 'chapters#sort'
  resources :books
  devise_for :users
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  namespace :api, defaults: { format: :json } do
    get '/auth/user', to: 'sessions#user'
    get '/auth/books', to: 'sessions#books'
    get '/auth/books/:id', to: 'sessions#showbook'
    get '/auth/chapter/:book_id', to: 'sessions#showchapter'
  end
end
