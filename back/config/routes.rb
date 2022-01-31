Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  namespace :api, defaults: { format: :json } do
    get '/auth/user', to: 'sessions#user'
  end
end
