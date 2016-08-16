Rails.application.routes.draw do

  resources :avatars
  resources :uploads
  resources :votes
  resources :posts
  resources :topics do
    resources :posts 
  end

  resources :users do
    resources :avatars 
    collection do
      post "send_password_reset_link" 
      post "reset_password" 
      get "forgotten_password" 
      get "admin_up" 
    end
  end

  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'topics#index'

end
