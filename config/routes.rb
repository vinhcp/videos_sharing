Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'auth/sessions' }

  resources :videos, only: %i[new create]

  root to: 'videos#index'
end
