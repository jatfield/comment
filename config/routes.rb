Rails.application.routes.draw do

  resources :avatars, only: [:new, :create, :edit, :update, :destroy]
#  resources :uploads
#  resources :votes
  resources :posts, only: [:index, :create, :edit, :update, :destroy]
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
      get "set_custom_vars" 
    end
  end

  resources :user_sessions, only: [:create, :destroy]
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'topics#index'

end
